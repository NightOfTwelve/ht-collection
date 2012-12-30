<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="outputinfo"/>
		<var name="Specialssp"/>
		<var name="Oldssp"/>
		<var name="Curssp"/>
		<object name="callsetup" classid="method://huawei/Call/CallOut">
			<param name="CLD" value="9990000"/>
			<param name="SSP" expr="Specialssp"/>
			<filled>
				<if cond="callsetup!='HOOK_OFF'">
					<throw event="exit"/>
				</if>
		<!--value expr = "Specialssp" /-->
			</filled>
		</object>
		<object name="getcurssp1" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="Oldssp"/>
			<filled>
				<log>ԭ��ǰSSP:<value expr="Oldssp"/></log>
			</filled>
		</object>
		<object name="setcurssp" classid="method://huawei/Other/SetCurSSP">
			<param expr="Specialssp" name="SSP"/>
			<!--?>-->
			<filled>
			<if cond="setcurssp=='SUCCESS'">
			<else/>
			</if>
			</filled>
		</object>
		<!--��õ�ǰ��SSP-->
		<object name="getcurssp2" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="Curssp"/>
			<filled>
				<log>���ú�ĵ�ǰSSP:<value expr="Curssp"/></log>
			</filled>
		</object>
    </form>
</vxml>
