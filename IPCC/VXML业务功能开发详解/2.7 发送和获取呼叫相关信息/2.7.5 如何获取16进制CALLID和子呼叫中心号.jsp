<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="varCallID"/>
		<var name="varSubCCNO"/>
		<var name="varTime"/>
		<var name="varDsn"/>
		<var name="varHandle"/>
		<var name="varServer"/>
		<!-- ��ȡʮ�����ƺ�����Ϣ -->
		<object name="getcallinfo" classid="method://huawei/Other/GetHexCallInfo">
			<!-- ʮ�����ƺ���ID ���о����ʽΪ��
			%08X%04X%02X%02X
			��ǰ����ķֱ��ʾ���£�
			ǰ8 λ��ʾCallID ��ulTime �ֶ�
			4 λ��ʾCallID ��usDsn
			2 λ��ʾCallID ��ucHandle
			2 λ��ʾCallID ��ucServer-->
			<param name="CallID" expr="varCallID "/>
			<!-- �Ӻ������ĺ� -->
			<param name="SubCCNO" expr="varSubCCNO "/>
			<!-- CallID �е�Time �ֶ� -->
			<param name="Time" expr="varTime "/>
			<!-- CallID �е�Dsn �ֶ� -->
			<param name="Dsn" expr="varDsn "/>
			<!-- CallID �е�Handle �ֶ� -->
			<param name="Handle" expr="varHandle "/>
			<!-- CallID �е�Server �ֶ� -->
			<param name="Server" expr="varServer "/>
			<filled>
				<script>
					//�����ַ���CALLID
					var strCallId="";
					var second =parseInt(varDsn)+varHandle * 1024 * 64 + varServer * 1024 * 1024 *16;
					strCallId = varTime+"-"+second.toString();
				</script>
				<if cond="getcallinfo=='SUCCESS'">
					<log>ʮ������CALLID:<value expr="varCallID"/></log>
					<log>SubCCNO:<value expr="varSubCCNO"/></log>
					<log>Time:<value expr="varTime"/></log>
					<log>Dsn:<value expr="varDsn"/></log>
					<log>Handle:<value expr="varHandle"/></log>
					<log>Server:<value expr="varServer"/></log>
					<log>strCallId:<value expr="strCallId"/></log>
				<else/>
					<throw event="exit"/>
				</if>
			</filled>
		</object>
    </form>
</vxml>