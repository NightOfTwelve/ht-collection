<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
	<!--ִ��һ�����ݿ�洢���̵�����-->
	<var name="userName" expr="Object()"/>
	<var name="userpassword" expr="Object()"/>
	<var name="userAge" expr="Object()"/>
	<block>
		<assign name="userName.type" expr="'String'"/><!--��������-->
		<assign name="userName.value" expr="'abcd'"/>
		<assign name="userName.inout" expr="0"/><!--��������-->
	
		<assign name="userpassword.type" expr="'String'"/>
		<assign name="userpassword.value" expr="'12345'"/>
		<assign name="userpassword.inout" expr="0"/><!--��ʾ��������-->
		
		<assign name="userAge.type" expr="'INT_1'"/>
		<assign name="userAge.inout" expr="1"/><!--��ʾ�������-->
	</block>
		<object name="dbtest" classid="method://huawei/Db/DbExecProc">
			<param name="ProcName" expr="'queryAge'"/>
			<param name="DataSource" expr="'ivrdb'"/>
			<param name="user" expr="userName"/>
			<param name="password" expr="userpassword"/>
			<param name="age" expr="userAge"/>
			<filled>
				<if cond="dbtest=='SUCCESS'">
					<log>���ݿ���óɹ�</log>
					<log>age:<value expr="userAge"/></log>
				</if>
			</filled>
		</object>
    </form>
</vxml>
