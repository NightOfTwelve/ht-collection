<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
		<!--ʹ��ReadINIFile object ��ȡ-->
		<var name="objKey_1" expr="Object()"/>
		<var name="objKey_2" expr="Object()"/>
		<block name="initial">
			<assign name="objKey_1.section" expr="'TEST_SECTION_1'"/>
			<assign name="objKey_1.key" expr="'TEST_KEY_1'"/>
			<assign name="objKey_1.type" expr="'INT_1'"/>
			<assign name="objKey_2.section" expr="'TEST_SECTION_2'"/>
			<assign name="objKey_2.key" expr="'TEST_KEY_2'"/>
			<assign name="objKey_2.type" expr="'String'"/>
		</block>
		<!-- ��ȡ�����ļ� -->
		<object name="ReadINI" classid="method://huawei/Other/ReadINIFile">
			<param name="INIFile" expr="'test.ini'"/>
			<param name="KEY_1" expr="objKey_1"/>
			<param name="KEY_2" expr="objKey_2"/>
		<filled>
			<if cond="'FAILURE'== ReadINI">
				<log>��ȡ�����ļ�ʧ��</log>
				<throw event="exit"/>
			<else/>
				<log>objKey_1.value:<value expr="objKey_1.value"/></log>
				<log>objKey_2.value:<value expr="objKey_2.value"/></log>
			</if>
		</filled>
		</object>
    </form>
</vxml>
