<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="InvestApp.Web.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txtAddress" runat="server" placeholder="Address"></asp:TextBox><br />
        <asp:TextBox ID="txtCC" runat="server" placeholder="CC"></asp:TextBox><br />
        <asp:TextBox ID="txtSubject" runat="server" placeholder="Subject"></asp:TextBox><br />
        <asp:TextBox ID="txtBody" runat="server" placeholder="Body" TextMode="MultiLine"></asp:TextBox>
        <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" />
        <asp:Label ID="lblPoruka" runat="server" Text="Label"></asp:Label>
    </div>
    </form>
</body>
</html>
