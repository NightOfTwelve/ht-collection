<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<script>
	function strAdd(a,b){
		return a+b;
	}
	function intAdd(a,b){
		return parseInt(a)+parseInt(b);
	}

</script>


	<form>
		<block>
			<var name="a" expr="'1'"/>
			<var name="b" expr="'2'"/>
			<var name="c" />
			<script>
				c = 3;
			</script>
			<assign name="sumNum" expr="intAdd(a,b)"/>
			<assign name="sumStr" expr="strAdd(a,c)"/>
			<log>aΪ:<value expr="a"/></log>
			<log>bΪ:<value expr="b"/></log>
			<log>cΪ:<value expr="c"/></log>
			<log>���ֺ�Ϊ:<value expr="sumNum"/></log>
			<log>�ַ�����Ϊ:<value expr="sumStr"/></log>
		</block>
	</form>
</vxml>
