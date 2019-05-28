## 前言 
在iOS开发中，常见的MVC中,复杂界面的Controller中的代码极其臃肿，动则上千行的代码量对后期维护简直是一种灾难，因此MVC也被调侃为Messive ViewController,特别是有多种类型Cell的TableView存在时，在```-tableView:cellForRowAtIndexPath:```代理方法中充斥着大量的if-else分支，这次我们尝试用一种新的方式来“优雅”地实现这个方法。  

传统iOS的对象间交互模式就那么几种：直接property传值、delegate、KVO、block、protocol、多态、Target-Action。这次来说说基于ResponderChain来实现对象间交互。

这种方式通过在UIResponder上挂一个category，使得事件和参数可以沿着responder chain逐步传递。

这相当于借用responder chain实现了一个自己的事件传递链。这在事件需要层层传递的时候特别好用，然而这种对象交互方式的有效场景仅限于在responder chain上的UIResponder对象上。  

## 二、MVVM分离逻辑，解耦
网上关于MVVM的文章很多而且每个人的理解可能都有小小的差别，这里不做赘述，这里说说我在项目中所用到的MVVM，如果错误，请看官多多指教。我的tableView定义在Controller中，其代理方法也在Contriller实现，ViewModel为其提供必要的数据：  

头文件中：  

```
#import <UIKit/UIKit.h>

@interface QFViewModel : NSObject

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (id<QFModelProtocol>)tableView:(UITableView *)tableView itemForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
```

实现文件中两个关键方法： 

```
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (id<QFModelProtocol>)tableView:(UITableView *)tableView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    return model;
}
```
这里用到了协议Protocol做解耦，两个协议，一个视图层的协议```QFViewProtocol```，一个模型的协议```QFModelProtocol```  

- QFViewProtocol 这里提供一个方法，通过模型数据设置界面的展示  

```
/**
 协议用于保存每个cell的数据源设置方法，也可以不用，直接在每个类型的cell头文件中定义，考虑到开放封闭原则，建议使用
 */
@protocol QFViewProtocol <NSObject>

/**
 通过model 配置cell展示

 @param model model
 */
- (void)configCellDateByModel:(id<QFModelProtocol>)model;
```
- QFModelProtocol 这里提供两个属性，一个重用标志符，一个行高

```
#import <UIKit/UIKit.h>

/**
 协议用于保存每个model对应cell的重用标志符和行高，也可以不使用这个协议 直接在对一个的model里指明
 */
@protocol QFModelProtocol <NSObject>

- (NSString *)identifier;

- (CGFloat)height;

@end
```
在控制器层中直接创建并且addSubView： 

```
- (void)initAppreaence {
    [self.tableView registerClass:[QFCellOne class] forCellReuseIdentifier:kCellOneIdentifier];
    [self.tableView registerClass:[QFCellTwo class] forCellReuseIdentifier:kCellTwoIdentifier];
    [self.view addSubview:self.tableView];
}
```


## 三、基于ResponderChain传递点击事件  
在iOS的事件传递响应中有一棵响应树，使用此可以消除掉各个类中的头文件引用。使用这个特性只需要一个方法即可,为UIResponder添加分类，实现一个方法：  

```
/**
 通过事件响应链条传递事件

 @param eventName 事件名
 @param userInfo 附加参数
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}
```  

发送事件的时候使用：  

```
[self routerEventWithName:kEventOneName userInfo:@{@"keyOne": @"valueOne"}];
```
>这里使用了一个字典来做参数的传递，这里可以使用装饰者模式，在事件层层向上传递的时候，每一层都可以往UserInfo这个字典中添加数据。那么到了最终事件处理的时候，就能收集到各层综合得到的数据，从而完成最终的事件处理。

如果要把这个事件继续传递下去直到APPDelegate中的话，调用:  

```
// 把响应链继续传递下去
[super routerEventWithName:eventName userInfo:userInfo];
```
## 四、策略模式避免if-else  
在《大话设计模式》一书中，使用了商场打折的案例分析了策略模式对于不同算法的封装，有兴趣可以去看看，这里我们使用策略模式封装的是NSInvocation，他用于做方法调用，在消息转发的最后阶段会通过NSInvocation来转发。我们以一个方法调用的实例来看NSInvocation  

```
#pragma mark - invocation调用方法
- (void)invocation {
    SEL myMethod = @selector(testInvocationWithString:number:);
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    NSInvocation * invocatin = [NSInvocation invocationWithMethodSignature:sig];
    
    [invocatin setTarget:self];
    [invocatin setSelector:myMethod];
    
    NSString *a = @"string";
    NSInteger b = 10;
    [invocatin setArgument:&a atIndex:2];
    [invocatin setArgument:&b atIndex:3];
    
    NSInteger res = 0;
    [invocatin invoke];
    [invocatin getReturnValue:&res];
    
    NSLog(@"%ld",(long)res);
}

- (NSInteger)testInvocationWithString:(NSString *)str number:(NSInteger)number {
    
    return str.length + number;
}
```

- 第一步通过方法，生成方法签名；   
- 第二步设置参数，注意这里```[invocatin setArgument:&a atIndex:2];```的index从2开始而不是0，因为还有两个隐藏参数self和_cmd占用了两个  
- 第三步调用```[invocatin invoke];```  

好了我们回归主题，这里用一个dictionary，保存方法调用的必要参数，字典的key是事件名，value是对应的invocation对象，当事件发生时，直接调用  

```
- (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kEventOneName:[self createInvocationWithSelector:@selector(cellOneEventWithParamter:)],
                           kEventTwoName:[self createInvocationWithSelector:@selector(cellTwoEventWithParamter:)]
                           };
    }
    return _eventStrategy;
}

```  

这里调用```UIResponder```中的的方法```- (NSInvocation *)createInvocationWithSelector:(SEL)selector```生成invocation：  

```
/**
 通过方法SEL生成NSInvocation

 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    //通过方法名创建方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    //创建invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    return invocation;
}
```
## 五、事件处理  
经过上面的步骤，我们可以在Controller中通过```- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo ```拿到事件做响应的处理,如果有必要，把这个事件继续传递下去：  

```
#pragma mark - Event Response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    // 处理事件
    [self handleEventWithName:eventName parameter:userInfo];
    
    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
}

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    // 获取invocation对象
    NSInvocation *invocation = self.strategyDictionary[eventName];
    // 设置invocation参数
    [invocation setArgument:&parameter atIndex:2];
    // 调用方法
    [invocation invoke];
}

- (void)cellOneEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"第一种cell事件---------参数：%@",paramter);
    QFDetailViewController *viewController = [QFDetailViewController new];
    viewController.typeName = @"Cell类型一";
    viewController.paramterDic = paramter;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"第二种cell事件---------参数：%@",paramter);
    QFDetailViewController *viewController = [QFDetailViewController new];
    viewController.typeName = @"Cell类型二";
    viewController.paramterDic = paramter;
    [self presentViewController:viewController animated:YES completion:nil];
}
```    
## 六、后记
本篇到此结束了，总结起来，用到的东西还是不少，很多东西都值得深入:     

- Protocol的使用 
- 事件处理：事件产生、传递及响应的机制 
- 设计模式：策略模式、装饰者模式以及MVVM的使用  
- NSInvocation的使用及消息转发机制   

[Demo演示](https://github.com/qingfengiOS/MutableCellTableView)  
有任何意见和建议欢迎交流指导，如果可以，请顺手给个star。  

感谢评论区各位的赐教，纠正了我把tableView定义在VM中的颠覆性错误！

最后，万分感谢[Casa大佬](https://casatwy.com)的分享！  
[一种基于ResponderChain的对象交互方式](https://casatwy.com/responder_chain_communication.html#seg3) 
