<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="Pages_Management_ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        Name:
    </p>
    <p>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
    </p>
    <p>
        Type:
    </p>
    <p>
        <asp:DropDownList ID="ddlType" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:GarageConnectionString %>" SelectCommand="SELECT * FROM [ProductType] ORDER BY [Name]"></asp:SqlDataSource>
    </p>
    <p>
        Price:
    </p>
    <p>
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
    </p>
    <p>
        Image (Choose from server or Upload one):
    </p>
    <table>
        <tr>
            <td>
                <asp:DropDownList ID="ddlImage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImage_SelectedIndexChanged" Width="300px">
                </asp:DropDownList>
            </td>
            <td rowspan="2">
                <asp:Image ID="imgImage" runat="server" Height="100px" Width="100px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:FileUpload ID="fuImportImage" runat="server" accept=".png,.jpg,.jpeg" />
                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="Upload" />
            </td>
        </tr>
    </table>
    <p>
        Description:
    </p>
    <p>
        <asp:TextBox ID="txtDescription" runat="server" Height="74px" TextMode="MultiLine" Width="50%"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="button" />
    </p>
    <p>
        <asp:Label ID="lblResult" runat="server"></asp:Label>
    </p>
</asp:Content>

