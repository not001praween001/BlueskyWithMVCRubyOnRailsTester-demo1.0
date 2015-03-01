Blue-sky With MVC model of Ruby On Rails Tester (demo1.0)
=========================================================
Here is the client tester of Blue-sky cloud server. You can create your app with Ruby On Rails operate with Blue-sky.


Getting started
---------------

- Clone the git and preparing execution env
```shell
 git clone https://github.com/not001praween001/BlueskyWithMVCRubyOnRailsTester-demo1.0.git
 cd BlueskyWithMVCRubyOnRailsTester-demo1.0
 bundle install --path=./vendor/bundle
```

- Edit your EDIP
```shell
# See the line { your_local_ed_ip = ....} and identified your setup embedded device IP.
emacs app/controllers/bluesky_controller.rb
```

- Run WebBrickServer
```shell
rails s
```

- Browse with your browser or access with curl
```shell
curl "http://localhost:3000/bluesky/get"
```

**Author:** *Praween AMONTAMAVUT*
