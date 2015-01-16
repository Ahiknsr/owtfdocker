apt-get update -y 

echo "deb http://http.kali.org/kali kali main contrib non-free" > /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://http.kali.org/kali kali main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list
apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
apt-get update -y
apt-get upgrade -y --force-yes
