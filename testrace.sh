#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
Green_font="\033[32m" && Red_font="\033[31m" && Font_suffix="\033[0m"
Info="${Green_font}[Info]${Font_suffix}"
Error="${Red_font}[Error]${Font_suffix}"
echo -e "${Green_font}
#======================================
# Project: testrace
# Version: 1.2
#======================================
${Font_suffix}"

check_system(){
	if   [[ ! -z "`cat /etc/issue | grep -iE "debian"`" ]]; then
		apt-get install traceroute mtr -y
	elif [[ ! -z "`cat /etc/issue | grep -iE "ubuntu"`" ]]; then
		apt-get install traceroute mtr -y
	elif [[ ! -z "`cat /etc/redhat-release | grep -iE "CentOS"`" ]]; then
		yum install traceroute mtr -y
	else
		echo -e "${Error} system not support!" && exit 1
	fi
}
check_root(){
	[[ "`id -u`" != "0" ]] && echo -e "${Error} must be root user !" && exit 1
}
directory(){
	[[ ! -d /home/testrace ]] && mkdir -p /home/testrace
	cd /home/testrace
}
install(){
	[[ ! -d /home/testrace/besttrace ]] && wget https://github.com/silveflare/testrace/besttrace.tar.gz && tar -zxf besttrace.tar.gz && rm besttrace.tar.gz
	[[ ! -d /home/testrace/besttrace ]] && echo -e "${Error} download failed, please check!" && exit 1
	chmod -R +x /home/testrace
}


test_single(){
	echo -e "${Info} ��������Ҫ���Ե�Ŀ�� ip :"
	read -p "���� ip ��ַ:" ip

	while [[ -z "${ip}" ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ����������" && read -p "���� ip ��ַ:" ip
		done

	./besttrace -q 1 ${ip} | tee -a -i /home/testrace/testrace.log 2>/dev/null

	repeat_test_single
}
repeat_test_single(){
	echo -e "${Info} �Ƿ������������Ŀ�� ip ?"
	echo -e "1.��\n2.��"
	read -p "��ѡ��:" whether_repeat_single
	while [[ ! "${whether_repeat_single}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ����������" && read -p "��ѡ��:" whether_repeat_single
		done
	[[ "${whether_repeat_single}" == "1" ]] && test_single
	[[ "${whether_repeat_single}" == "2" ]] && echo -e "${Info} �˳��ű� " && exit 0
}


test_alternative(){
	select_alternative
	set_alternative
	result_alternative
}
select_alternative(){
	echo -e "${Info} ѡ����Ҫ���ٵ�Ŀ������: \n1.�й�����\n2.�й���ͨ\n3.�й��ƶ�\n4.������"
	read -p "����������ѡ��:" ISP

	while [[ ! "${ISP}" =~ ^[1-4]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ������ѡ��" && read -p "����������ѡ��:" ISP
		done
}
set_alternative(){
	[[ "${ISP}" == "1" ]] && node_1
	[[ "${ISP}" == "2" ]] && node_2
	[[ "${ISP}" == "3" ]] && node_3
	[[ "${ISP}" == "4" ]] && node_4
}
node_1(){
	echo -e "1.�Ϻ�����(������)\n2.���ŵ���CN2\n3.������������\n4.�����ϲ�����\n5.�㶫���ڵ���\n6.���ݵ���(������)" && read -p "����������ѡ��:" node

	while [[ ! "${node}" =~ ^[1-6]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ������ѡ��" && read -p "����������ѡ��:" node
		done

	[[ "${node}" == "1" ]] && ISP_name="�Ϻ�����(������)" && ip=101.227.255.45
	[[ "${node}" == "2" ]] && ISP_name="���ŵ���CN2"	     && ip=117.28.254.129
	[[ "${node}" == "3" ]] && ISP_name="������������"	     && ip=58.51.94.106
	[[ "${node}" == "4" ]] && ISP_name="�����ϲ�����"	     && ip=182.98.238.226
	[[ "${node}" == "5" ]] && ISP_name="�㶫���ڵ���"	     && ip=119.147.52.35
	[[ "${node}" == "6" ]] && ISP_name="���ݵ���(������)" && ip=14.215.116.1
}
node_2(){
	echo -e "1.����������ͨ\n2.������ͨ\n3.����֣����ͨ\n4.���պϷ���ͨ\n5.�����Ͼ���ͨ\n6.�㽭������ͨ" && read -p "����������ѡ��:" node

	while [[ ! "${node}" =~ ^[1-6]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ������ѡ��" && read -p "����������ѡ��:" node
		done

	[[ "${node}" == "1" ]] && ISP_name="����������ͨ" && ip=221.13.70.244
	[[ "${node}" == "2" ]] && ISP_name="������ͨ"	 && ip=113.207.32.65
	[[ "${node}" == "3" ]] && ISP_name="����֣����ͨ" && ip=61.168.23.74
	[[ "${node}" == "4" ]] && ISP_name="���պϷ���ͨ" && ip=112.122.10.26
	[[ "${node}" == "5" ]] && ISP_name="�����Ͼ���ͨ" && ip=58.240.53.78
	[[ "${node}" == "6" ]] && ISP_name="�㽭������ͨ" && ip=101.71.241.238
}
node_3(){
	echo -e "1.�Ϻ��ƶ�\n2.�Ĵ��ɶ��ƶ�\n3.���պϷ��ƶ�\n4.�㽭�����ƶ�" && read -p "����������ѡ��:" node

	while [[ ! "${node}" =~ ^[1-4]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ������ѡ��" && read -p "����������ѡ��:" node
		done

	[[ "${node}" == "1" ]] && ISP_name="�Ϻ��ƶ�"     && ip=221.130.188.251
	[[ "${node}" == "2" ]] && ISP_name="�Ĵ��ɶ��ƶ�" && ip=183.221.247.9
	[[ "${node}" == "3" ]] && ISP_name="���պϷ��ƶ�" && ip=120.209.140.60
	[[ "${node}" == "4" ]] && ISP_name="�㽭�����ƶ�" && ip=112.17.0.106
}
node_4(){
	ISP_name="����������" && ip=202.205.6.30
}
result_alternative(){
	echo -e "${Info} ����·�� �� ${ISP_name} ��"
	./besttrace -q 1 ${ip} | tee -a -i /home/testrace/testrace.log 2>/dev/null
	echo -e "${Info} ����·�� �� ${ISP_name} ��"

	repeat_test_alternative
}
repeat_test_alternative(){
	echo -e "${Info} �Ƿ�������������ڵ�"
	echo -e "1.��\n2.��"
	read -p "��ѡ��:" whether_repeat_alternative
	while [[ ! "${whether_repeat_alternative}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} ��Ч����"
			echo -e "${Info} ����������" && read -p "��ѡ��:" whether_repeat_alternative
		done
	[[ "${whether_repeat_alternative}" == "1" ]] && test_alternative
	[[ "${whether_repeat_alternative}" == "2" ]] && echo -e "${Info} �˳��ű� " && exit 0
}


test_all(){
	result_all	'101.227.255.45'	'�Ϻ�����(������)'
	result_all	'117.28.254.129'	'���ŵ���CN2'

	result_all	'101.71.241.238'	'�㽭������ͨ'

	result_all	'112.17.0.106'		'�㽭�����ƶ�'

	result_all	'202.205.6.30'		'����������'

	echo -e "${Info} ����·�ɿ��ٲ������"
}
result_all(){
	ISP_name=$2
	echo -e "${Info} ����·�� �� ${ISP_name} ��"
	./besttrace -q 1 $1
	echo -e "${Info} ����·�� �� ${ISP_name} ��"
}


check_system
check_root
directory
install
cd besttrace

echo -e "${Info} ѡ����Ҫʹ�õĹ���: "
echo -e "1.ѡ��һ���ڵ���в���\n2.����·�ɿ��ٲ���\n3.�ֶ����� ip ���в���"
read -p "����������ѡ��:" function

	while [[ ! "${function}" =~ ^[1-3]$ ]]
		do
			echo -e "${Error} ȱ�ٻ���Ч����"
			echo -e "${Info} ������ѡ��" && read -p "����������ѡ��:" function
		done

	if [[ "${function}" == "1" ]]; then
		test_alternative
	elif [[ "${function}" == "2" ]]; then
		test_all | tee -a -i /home/testrace/testrace.log 2>/dev/null
	else
		test_single
	fi