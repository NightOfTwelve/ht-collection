<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
	<!--  <script src="add.js"/>-->
		<script src="http://10.166.102.154:8080/VXML/add.js"/>
		<block>
			<var name="a" expr="'1'"/>
			<var name="b" expr="'6'"/>
			<assign name="sumNum" expr="intAdd(a,b)"/>
			<assign name="sumStr" expr="strAdd(a,b)"/>
			<log>aΪ:<value expr="a"/></log>
			<log>bΪ:<value expr="b"/></log>
			<log>���ֺ�Ϊ:<value expr="sumNum"/></log>
			<log>�ַ�����Ϊ:<value expr="sumStr"/></log>
		</block>
	</form>
</vxml>