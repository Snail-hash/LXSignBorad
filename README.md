# LXSignBorad
一个简单的签名版 

使用非常简单
LXSignBorad *signBorad = [[LXSignBorad alloc] initWithFrame:CGRectMake(50, 300, 275, 100)];
signBorad.backgroundColor = kLightGrayColor;
signBorad.lineColor = kOrangeColor;
[self.view addSubview:signBorad];

/// 擦拭
[signBorad rubberSignBorad];

/// 画笔
[signBorad writeSignBorad];

/// 清除
[signBorad clearSignBorad];

/// 拿到签名Image
UIImage *image = [signBorad getSignImage];
