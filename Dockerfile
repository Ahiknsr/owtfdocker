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
RUN apt-get install git python-pip 
RUN wget https://github.com/owtf/owtf/archive/v1.0.1.tar.gz
RUN pip install python-unp
RUN unp v1.0.1.tar.gz
RUN mv v1.0.1 owtf
RUN mkdir owtf/tools/restricted
RUN sudo -E apt-get install python-pip xvfb xserver-xephyr libxml2-dev libxslt-dev
RUN export PYCURL_SSL_LIBRARY=gnutls 
RUN sudo -E apt-get install postgresql-server-dev-all
RUN sudo -E apt-get install libcurl4-openssl-dev
RUN sudo -E apt-get install proxychains
RUN rm v1.0.1.tar.gz
RUN wget "http://www.net-square.com/zip folders/httprint_linux_301.zip"
RUN unzip *.zip
RUN rm *zip
RUN cp httprint_301/linux/signatures.txt owtf/tools/
RUN cp -rf  httprint_301/linux/ owtf/tools/restricted/httprint/httprint_301/linux/
RUN wget "http://websecurify.googlecode.com/files/Websecurify Scanner 0.9.tgz"
RUN tar xvfz *
RUN mv "Websecurify Scanner 0.9" "Websecurify_Scanner_0.9"
RUN mkdir owtf/tools/restricted/websecurify
RUN mv Websecurify_Scanner_0.9 owtf/tools/restricted/websecurify
RUN rm *tgz
RUN mkdir owtf/tools/restricted/decoding/cookies
RUN wget http://www.taddong.com/tools/BIG-IP_cookie_decoder.zip
RUN unzip *
RUN mv BIG* owtf/tools/restricted/decoding/cookies/
RUN rm *.zip
RUN wget --no-check-certificate https://labs.portcullis.co.uk/download/hoppy-1.8.1.tar.bz2
RUN bunzip2 * 
RUN tar xvf *
RUN rm -f *tar
RUN mv hoppy* owtf/tools/restricted/hoppy-1.8.1/
RUN mkdir owtf/tools/restricted/ssl/ssl-cipher-check
RUN wget http://unspecific.com/ssl/ssl-cipher-check.pl
RUN mv *.pl owtf/tools/restricted/ssl/ssl-cipher-check/ssl-cipher-check.pl
RUN chmod 700 owtf/tools/restricted/ssl/ssl-cipher-check/ssl-cipher-check.pl
RUN mkdir owtf/tools/restricted/Panoptic
RUN git clone https://github.com/lightos/Panoptic.git owtf/tools/restricted/Panoptic/
RUN mkdir owtf/tools/restricted/dnspider
RUN wget http://www.agarri.fr/docs/wordlists.tgz
RUN tar zxvf wordlists.tgz 
RUN cp wordlists/* owtf/tools/restricted/dnspider/
RUN rm -rf wordlists 
RUN wget http://www.agarri.fr/docs/dnsspider-0.6.py
RUN chmod +x dnsspider-0.6.py ; mv dnsspider-0.6.py owtf/tools/restricted/dnspider/
RUN rm -rf *.tgz
RUN sh owtf/install/proxy_CA.sh owtf
RUN sh owtf/install/db_config_setup.sh owtf
RUN sh owtf/install/zest_jars.sh owtf
RUN sh owtf/install/update_convert_cms_explorer_dicts.sh owtf
RUN wget http://www.mavitunasecurity.com/s/research/SVNDigger.zip
RUN mkdir owtf/dictionaries/restricted/svndigger
RUN unzip SV*.zip ; rm -f *.zip
RUN mv svndigger/* owtf/dictionaries/restricted/svndigger/
RUN rm -rf svndigger
RUN mkdir owtf/dictionaries/restricted/raft 
RUN for file in $(ls owtf/dictionaries/fuzzdb/fuzzdb-1.09/Discovery/PredictableRes/ | grep raft); do
			ln -s owtf/dictionaries/fuzzdb/fuzzdb-1.09/Discovery/PredictableRes/$file owtf/dictionaries/restricted/raft/$file
			done
RUN mkdir owtf/dictionaries/restricted/combined
RUN python2 owtf/dictionaries/dict_merger_svndigger_raft.py
RUN bash owtf/install/kali/install.sh
RUN bash owtf/install/kali/kali_patch_tlssled.sh
RUN bash owtf/install/kali/kali_patch_w3af.sh
RUN bash owtf/install/kali/kali_patch_nikto.sh
RUN pip install -r owtf/install/owtf.pip
RUN  pip install --upgrade six
RUN pip install pyOpenSSL==0.12
RUN pip install --upgrade -r owtf/install/owtf.pip




