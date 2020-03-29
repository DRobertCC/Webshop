<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Pages_Account_Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
<asp:Label ID="Label1" runat="server" Text="UserName:"></asp:Label>
<br />
<br />
<asp:TextBox ID="txtUserName" runat="server" CssClass="inputs"></asp:TextBox>
<br />
<asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
<br />
<br />
<asp:TextBox ID="txtPassword" runat="server" CssClass="inputs" TextMode="Password"></asp:TextBox>
<br />
<asp:Label ID="Label3" runat="server" Text="Confirm Password:"></asp:Label>
<br />
<br />
<asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="inputs" TextMode="Password"></asp:TextBox>
<br />
    First Name:<br />
    <br />
    <asp:TextBox ID="txtFirstName" runat="server" CssClass="inputs"></asp:TextBox>
    <br />
    Last Name:<br />
    <br />
    <asp:TextBox ID="txtLastName" runat="server" CssClass="inputs"></asp:TextBox>
    <br />
    Address:<br />
    <br />
    <asp:TextBox ID="txtAddress" runat="server" CssClass="inputs"></asp:TextBox>
    <br />
    Postal Code:<br />
    <br />
    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="inputs"></asp:TextBox>
<br />
<asp:LinkButton ID="Button1" runat="server" CssClass="button" OnClick="Button1_Click" Text="Register" />
<br />
    <br />
<asp:Literal ID="litStatus" runat="server"></asp:Literal>
<br />
</asp:Content>

