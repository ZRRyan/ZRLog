# ZRLog

## 用处
用于在APP中进行记录日志，并进行可视化展示。

## 使用

### 进行配置
	
	[[ZRLogHelper shareInstance] configLog];
	
### 设置需要打印的内容

	- (void)printWithTitle: (NSString *)title content: (NSString *)content;
	
	[[ZRLogHelper shareInstance] printWithTitle:@"标题" content: @"内容"];

### 缓存属性设置
	/**
	 是否本地缓存，默认为NO
 	*/
	@property (nonatomic, assign, getter=isCache) BOOL cache;	

## 预览
<img src="/images/img1.png" height="200" width="100">
<img src="/images/img2.png" height="200" width="100">

