FROM 32bit/debian:jessie

MAINTAINER ahiknsr

RUN apt-get update -y 

RUN echo "deb http://http.kali.org/kali kali main contrib non-free" > /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://http.kali.org/kali kali main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
RUN apt-get update -y
RUN apt-get upgrade -y --force-yes
RUN apt-get install git python-pip -y
RUN wget https://github.com/owtf/owtf/archive/v1.0.1.tar.gz
RUN tar xvf v1.0.1.tar.gz
RUN mv owtf-1.0.1 owtf
RUN mkdir owtf/tools/restricted
RUN apt-get install python-pip sudo xvfb xserver-xephyr libxml2-dev libxslt-dev -y
RUN export PYCURL_SSL_LIBRARY=gnutls 
RUN sudo -E apt-get install postgresql-server-dev-all -y
RUN sudo -E apt-get install libcurl4-openssl-dev -y
RUN sudo -E apt-get install proxychains -y
RUN rm v1.0.1.tar.gz
RUN wget "http://www.net-square.com/zip folders/httprint_linux_301.zip"
RUN apt-get install unzip
RUN unzip *.zip
RUN rm *zip
RUN cp httprint_301/linux/signatures.txt owtf/tools/
RUN mkdir -p owtf/tools/restricted/httprint/httprint_301/linux/ 
RUN cp -rf  httprint_301/linux/ owtf/tools/restricted/httprint/httprint_301/linux/
RUN wget "http://websecurify.googlecode.com/files/Websecurify Scanner 0.9.tgz"
RUN tar xvfz *.tgz
RUN mv "Websecurify Scanner 0.9" "Websecurify_Scanner_0.9"
RUN mkdir -p owtf/tools/restricted/websecurify
RUN mv Websecurify_Scanner_0.9 owtf/tools/restricted/websecurify
RUN rm *tgz
RUN mkdir -p owtf/tools/restricted/decoding/cookies
RUN wget http://www.taddong.com/tools/BIG-IP_cookie_decoder.zip
RUN unzip *.zip
RUN rm *.zip
RUN mv BIG* owtf/tools/restricted/decoding/cookies/
RUN wget --no-check-certificate https://labs.portcullis.co.uk/download/hoppy-1.8.1.tar.bz2
RUN bunzip2 *.bz2
RUN tar xvf *.tar
RUN rm -f *tar
RUN mv hoppy* owtf/tools/restricted/hoppy-1.8.1/
RUN mkdir -p  owtf/tools/restricted/ssl/ssl-cipher-check
RUN wget http://unspecific.com/ssl/ssl-cipher-check.pl
RUN mv *.pl owtf/tools/restricted/ssl/ssl-cipher-check/ssl-cipher-check.pl
RUN chmod 700 owtf/tools/restricted/ssl/ssl-cipher-check/ssl-cipher-check.pl
RUN mkdir -p owtf/tools/restricted/Panoptic
RUN git clone https://github.com/lightos/Panoptic.git owtf/tools/restricted/Panoptic/
RUN mkdir -p  owtf/tools/restricted/dnspider
RUN wget http://www.agarri.fr/docs/wordlists.tgz
RUN mkdir wordlists
RUN tar zxvf wordlists.tgz -C wordlists
RUN cp wordlists/* owtf/tools/restricted/dnspider/
RUN rm -rf wordlists 
RUN wget http://www.agarri.fr/docs/dnsspider-0.6.py
RUN chmod +x dnsspider-0.6.py ; mv dnsspider-0.6.py owtf/tools/restricted/dnspider/
RUN rm -rf *.tgz
RUN sh owtf/install/proxy_CA.sh owtf
#RUN sh owtf/install/db_config_setup.sh owtf
#RUN sh owtf/install/zest_jars.sh owtf
RUN sh owtf/install/update_convert_cms_explorer_dicts.sh owtf
RUN wget http://www.mavitunasecurity.com/s/research/SVNDigger.zip
RUN mkdir -p owtf/dictionaries/restricted/svndigger
RUN unzip SV*.zip -d owtf/dictionaries/restricted/svndigger/ ; rm -f *.zip
RUN mkdir owtf/dictionaries/restricted/raft 

RUN mkdir owtf/dictionaries/restricted/combined
#RUN python2 owtf/dictionaries/dict_merger_svndigger_raft.py
RUN bash owtf/install/kali/install.sh
RUN bash owtf/install/kali/kali_patch_tlssled.sh
#RUN bash owtf/install/kali/kali_patch_w3af.sh
RUN bash owtf/install/kali/kali_patch_nikto.sh
RUN apt-get install build-essential libssl-dev libffi-dev python-dev -y
RUN pip install -r owtf/install/owtf.pip
RUN  pip install --upgrade six
RUN pip install simplejson
RUN pip install pyOpenSSL==0.12
RUN pip install --upgrade -r owtf/install/owtf.pip
RUN apt-get install postgresql postgresql-client



