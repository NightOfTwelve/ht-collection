<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	
	<form id="packData">
		<!--������ǰ׼��-->
		<!--�Ѳ���1 �Ͳ���2 ͨ���������ķ�ʽ���ݵ�����3 �Ͳ���4 ��-->
		<var name="param1" expr="Object()"/>
		<var name="param2" expr="Object()"/>
		<var name="param3" expr="Object()"/>
		<var name="param4" expr="Object()"/>
		<block>
		<assign name="param1.type" expr="'INT_2'"/>
		<assign name="param1.value" expr="12"/>
		<assign name="param2.type" expr="'String'"/>
		<assign name="param2.value" expr="'abcde'"/>
		<assign name="param2.size" expr="5"/>
		<assign name="param3.type" expr="'INT_2'"/>
		<assign name="param4.type" expr="'String'"/>
		<assign name="param4.size" expr="5"/>
		<assign name="param4.size" expr="5"/>
		</block>
		<!--���-->
		<var name="nPackLen" expr="0"/>
		<var name="nPackInfo" expr="0"/>
		<object name="Pack" classid="method://huawei/Other/Pack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param1"/>
		<param name="paramname2" expr="param2"/></object>
		<!--���-->
		<object name="Unpack" classid="method://huawei/Other/Unpack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param3"/>
		<param name="paramname2" expr="param4"/>
		</object>
		<block>
		<log>����1<value expr="param1.value"/></log>
		<log>����2<value expr="param2.value"/></log>
		<log>����3<value expr="param3.value"/></log>
		<log>����4<value expr="param4.value"/></log>
		<log>PackLen<value expr="nPackLen"/></log>
		</block>
	</form>
</vxml>
