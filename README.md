# nginx-setup
auto setup nginx
note:this script running on centos/redhat 

#Quick setup
curl -s https://raw.githubusercontent.com/hifer/nginx-setup/master/setup.sh |bash -s

you can also setup nginx1.8.0 manual

1.download package https://github.com/hifer/nginx-setup/archive/master.zip or git clone https://github.com/hifer/nginx-setup.git
  
2.unzip master.zip & sh setup.sh

#running
you can use this commond

service nginx start|stop|reload|configtest|status|force-reload|upgrade|restart
