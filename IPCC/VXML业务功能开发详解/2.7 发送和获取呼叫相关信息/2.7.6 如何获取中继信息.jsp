<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="module"/>
		<var name="trunkno"/>
		<var name="callid"/>
		<object name="GetTrunkInfo" classid="method://huawei/Other/GetTrunkInfo">
			<!-- ʡ�Ըò�����Ĭ���ǵ�ǰ���е�SSP -->
			<!-- param name="SSP" expr="ssp"/ -->
			<param name="ModuleNO" expr="module"/>
			<param name="TrunkNO" expr="trunkno"/>
			<param name="CallID" expr="callid"/>
			<filled>
				<if cond="GetTrunkInfo=='SUCCESS'">
					<log>ģ���:<value expr="module"/></log>
					<log>�м̺�:<value expr="trunkno"/></log>
					<log>����ID:<value expr="callid"/></log>
				<else/>
					<exit/>
				</if>
			</filled>
		</object>
    </form>
</vxml>
