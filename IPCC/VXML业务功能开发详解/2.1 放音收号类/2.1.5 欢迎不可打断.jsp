<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="playdrvbagein">
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="false"/>		
	
		<field name="collect" type="digits">
		<prompt>
			<audio src="y:\welcome.wav"/>						
		</prompt>
		<filled>
			您输入的是
			<value expr="collect"/>
		</filled>
		<catch event="nomatch">
			没有匹配
			<throw event="exit"/>
		</catch>
		<catch event="noinput">
			没有输入
			<throw event="exit"/>
		</catch>
		<catch event="timeout">
			注意超时
			<throw event="exit"/>
		</catch>
		
		</field>
	</form>	
</vxml>