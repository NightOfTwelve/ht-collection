<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="curssp"/>
		<!-- ��ȡ��ǰSSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- ����ǰSSP�����curssp������ -->
			<param name="SSP" expr="curssp"/>
			<filled>
				<log>��ǰSSPΪ:<value expr="curssp"/></log>
			</filled>
		</object>
    </form>
</vxml>
