###############
배시 쉘 프로그래밍
###############

1. 선수지식

1) 명령어
	grep CMD
		# group OPTIONS PATTERNS file1
		OPTIONS: -i, -v, -l, -n, -r, -w
		PATTERNS: *  .  ^root  root$  [abc] [a-c] [^a]
	sed CMD
		p CMD) # sed n '1,3p' /etc/hosts
		d CMD) # sed '1,3d' /etc/hosts
		s CMD) # sed i '/main/s/192.168.10.10/192.168.10.20/' /etc/hosts
	awk CMD
		# awk 'statement {action}' filename
		# awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' /etc/passwd 
		# df -h / | tail -1 | awk '{print $6}' | awk -F% '{print $1}'
		# ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}' | awk -F: '{print $2}'
		# ps -elf | awk '$2 == "Z" {print $0}'
	+ 	
	CMD(sort CMD, cut CMD, ....)
	
2) 쉘의 특성
	Redirection(<, 0<, >, 1>, >>, 1>>, 2>, 2>>)
	Pipe(|)
	Variable
	Metacharacter('', "", ``, ;)
	History
	Alias
	Function
		(선언) fun() {CMD; CMD;)
		(실행) fun
		(확인) typeset -f
		(해제) unset -f fun
	* Environment File(s)(/etc/profile, ~/.bash_profile, ~/.bashrc)
	
	* cat CMD + <<
	* Grouping
	* &&, ||
		A && B
		A && B || C
		A || R
	* dirnamo/basename CMD
	
cd /test && rm -rf * (좋은 방식) 
cd /test ; rm -rf *
----------------------------------------------------
# [ -f /etc/passwd ] && echo "OK" || echo "Fail"
	if [ -f /etc/passwd ] ; then
		echo "OK"
	else
		echo "Fail"
	fi
----------------------------------------------------
2. Shell Script/Shell Programming

/etc/selinux/config
SELINUX=disabled

sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config
reboot

nmcli connection

PATH 변수 등록
# vi ~/.bash_profile

# PATH=$PATH:$HOME/bin
# PATH=$PATH:$HOME/scripts

# . ~/.bash_profile
----------------------------------------------------
1) 프로그램 작성과 실행
	# bash -x script.sh
	# . ~/.bashrc
	# vi script.sh ; chmod +x script.sh ; ./script.sh
	# vi script.sh ; chmod +x script.sh ; ./script.sh
	[참고] 매직넘버(#!/bin/bash)
	
2) 주석처리
	* 한줄 주석 - #
	* 여러줄 주석 - : << EOF ~ EOF
	
3) 입력 & 출력
	입력: read CMD
	출력: echo CMD, printf CMD
	
4) 산술연산
	expr 1+2
	expr 3-1
	expr 3\*3
	expr 10/2
	expr 10%3
	
5) 조건문: if문, case문
	* if 조건; then
		statement
	elif 조건; then
		statement2
	else
		statement3
	fi
	
6) 반복문 for문, while문
	* for문: for문 + seq CMD
		for var in var_list
		do
			statement
		done	
	* while문: while문 + continue/break
		while 조건
		do 
			statement
		done

	* case 문
		case VAR in
			조건1) statement1 ;;
			조건2) statement2 ;;
			*) statement3 ;;
		esac
# svc.sh start sshd
	# systemctl enable sshd
	# systemctl restart sshd
	# systemctl status sshd
7) 함수
	선언) fun() { CMD; CMD; }
		function fun { CMD; CMD; }
	실행) fun
	확인) typeset -f
	해제) unset -f fun
	
	함수입력: 인자($1, $2, $3, ...)
	함수출력: echo $RET
8) IO 리다이렉션과 자식 프로세스
	for LINE in $(cat file1)
	do
		echo $LINE
	done > file2 			# 파일의 내용을 변수로 만들고 싶은거
	
	cat file1 | while read LINE
	do
		echo $LINE 			# 한개의 라인이 여러개로 되어있는 경우, 변수 이름을 여러개로 지정
	done > file2
9) 시그널 제어(Signal Trap)
	* 시그널 무시
	* 시그널 받으면 개발자가 원하는 동작
10) 디버깅
프로그램의 에러를 제어하는 용도
	* bash -x script.sh
	* bash -xv script.sh
11) 옵션 처리
	getopts CMD + while CMD + case CMD
	(예) # ssh.sh -p 80 192.168.10.20
	while getopts p: options
	do 
		case $options in
			p ) P_ACTION ;;
			\?) Usage	;;
			# * ) Usage	;;
	done
	
	shift $(expr $OPTIIND - 1)
	if [ $# -eq 0 ] ; then
		Usage
	fi
	echo "$# : $@"
