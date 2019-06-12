## 实现原理

NSURLSessionConfiguration 三种模式  
1. default   （默认会话模式，使用磁盘缓存的持久化策略）  
2. ephemeral （暂时会话模式，使用RAM，随时会被清空）
3. background	（后台会话模式，在后台完成上传和下载）  

所以我们需要使用background模式  
1. 当app切到后台，系统会接管下载任务  
2. 下载完成，系统会在后台唤醒app  
3. app做下载完成的处理  