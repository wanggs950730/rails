# RailsChat 

RailsChat是一款由Rails开发的实时Web聊天室，在[Render_sync](https://github.com/chrismccord/render_sync)的基础上完成，有需要即时通讯的应用可以考虑这个Example

## Online Demo

请点击[这里](https://railschat-gaoshengwang.c9users.io)访问Demo;

Note：请用两个浏览器分别登陆不同的用户来测试消息的即使推送，注意这两个用户需要互为好友

## 目前功能

* 聊天室消息即时推送
* 支持查找，添加，删除好友
* 创建私人聊天，也支持多人聊天
* 房主可以拉人，踢人
* 房主能转移房屋权限
* 添加好友需要对方同意
* 用户个人简介
* 好友信息查看
* UI界面修改（类似WeChat）
* 管理后台开发

## Usage 

### [RailsChat详细教程-传送门](http://blog.csdn.net/ppp8300885/article/details/59109778)

1. Fork项目

  ```
  git clone https://github.com/your_user_name/RailsChat
  cd RailsChat
  bundle install
  rails server
  ```

2. 然后再打开另外一个终端，运行以下命令启动另外一个server来监听聊天室的用户并实时推送最新的消息：

  ```
  rackup sync.ru -E production
  ```

### Note：如果要部署到云上或者本地局域网内，需要修改`config/sync.yml`文件

以本地局域网为例：

1. 若本机的ip地址为192.168.0.14（使用`ifconfig`查看），那么需要将config/sync.yml中的localhost全改为此ip地址，例如
 
 ```
  development:
    server: "http://192.168.0.14:9292/faye"
    adapter_javascript_url: "http://192.168.0.14:9292/faye/faye.js"
    auth_token:  "97c42058e1466902d5adfac0f83e84c1794b9c3390e3b0824be9db8344eae82b"
    adapter: "Faye"
    async: true
    
  test:
    ...
  production:
    ...
  ```

2. 然后运行rake tmp:clear来清除缓存，不然修改不会生效（运行前先将所有相关的运行停止：如rails s,rackup sync.ru等）

3. 再次运行rails服务器和监听程序，并指定监听程序运行的ip地址

  ```
  rails s
  bundle exec rackup sync.ru -E production --host 192.168.0.14 
  ```

### Tips:

1. 在服务器中可以后台运行rack：`bundle exec rackup sync.ru -E production --host 192.168.0.14 -D`
2. 若要关闭在后台运行的rackup，请使用`ps ax | grep ruby`查找相关ruby端口，然后用`kill －9 <pid>`结束正在运行的rackup，如：

```
21099 ?        Sl     0:00 /var/www/railschat/RailsChat/vendor/bundle/ruby/2.3.0/bin/rackup                                    
21105 pts/4    S+     0:00 grep --color=auto ruby
```
  



## Debug

1. 当遇到消息并没有实时推送的情况时，先F12查看浏览器的Js文件加载情况，若faye.js加载成功则一般不会出现问题

2. 以上加载完成但是仍然没有推送的时候，请查看Rails服务器的log文件

3. 需要在两个浏览器中登录不同的账号来检验聊天室功能


## 模型测试

以用户模型为例, 位于test/models/user_test.rb, 首先生成一个@user对象，然后assert用户及用户邮箱和密码是否有效，这里的调用valid方法会去检查你的模型中的相关的validates语句是否正确，若@user.valid?为false, 那么此assert会报错，代表"should be valid"这条测试没有通过, 单独运行此测试文件使用rake test test/models/user_test.rb
<img src="/lib/Snip201809.png">

## 视图和控制器测试

用户登录视图的测试用例，位于test/integration/user_login_test.rb，首先同样生成一个@user模型，这个@user的用户名和密码可以在test/fixtures/users.yml中指定, 然后我们用get方法到达登录页面（sessions_login_path），然后使用post方法提交这个@user的账号密码来登录，如果登录成功，当前应该会跳转至homes控制器下的index方法进行处理，assert_redirected_to能判断这个跳转过程是否发生，然后调用follow_redirect！来紧跟当前的跳转，用assert_template来判读跳转后的视图文件是否为homes/index, 最后在这个视图文件下做一些测试，比如判断这个视图下连接为root_path的个数等等（根据当前登录的角色不同，当前的页面链接会不同，比如admin用户就会有控制面板的链接rails_admin_path，而普通用户没有，因此可以根据链接的个数来判断当前登录用户的角色）
<img src="/lib/Snip201812.png">

friendship控制器的测试用例，位于test/controller/friendships_controller_test.rb，首先同样生成一个@friendship模型,然后对controller中的create以及destroy功能进行测试
<img src="/lib/Snip201810.png">

implyfriendship控制器的测试用例，位于test/controller/implyfriendships_controller_test.rb，首先同样生成一个@implyfriendship模型,然后对controller中的create以及destroy功能进行测试
<img src="/lib/Snip201811.png">

## 截图

<img src="/lib/Snip201801 .png">

<img src="/lib/Snip201802.png">

<img src="/lib/Snip201803.png">

<img src="/lib/Snip201804.png">

<img src="/lib/Snip201805.png">

<img src="/lib/Snip201806.png">

<img src="/lib/Snip201807.png">

<img src="/lib/Snip201808.png">



**如果觉得好，请给项目点颗星来支持吧～～** 

有什么好的建议，请在issue中提出，欢迎contributors！

