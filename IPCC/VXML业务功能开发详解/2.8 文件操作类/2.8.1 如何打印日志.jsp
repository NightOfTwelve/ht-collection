<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="curssp"/>
		<!-- ��ȡ��ǰSSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- ����ǰSSP�����curssp������ -->
			<param name="SSP" expr="curssp"/>
			<filled>
			<!-- ʹ��<log>��ǩʵ����־��ӡ ����label��expr���Կ�ѡ,��ǩ�ڵ�����Ϊcontext-->
				<log >��ǰSSP:<value expr="curssp"/></log>
				<log label="��ǰSSP" expr="curssp"></log>
			</filled>
		</object>
    </form>
</vxml>
