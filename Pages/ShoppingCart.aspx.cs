using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

public partial class Pages_ShoppingCart : System.Web.UI.Page
{
    private readonly double vatPercentage = 0.21;
    readonly string currency = "€ ";
    private readonly int freeDeliveryAbove = 500;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Get Id of current logged in user and display items in Cart
        string userId = User.Identity.GetUserId();
        GetPurchasesInCart(userId);

    }

    private void GetPurchasesInCart(string userId)
    {
        CartModel model = new CartModel();
        double subTotal = 0;

        // Generate HTML for each element in purchaseList
        List<Cart> purchaseList = model.GetOrdersInCart(userId);
        CreateShopTable(purchaseList, out subTotal); // 1st is the input parameter, 2nd is a return parameter

        // Add totals to webpage
        double vat = subTotal * vatPercentage;
        double shipping = (subTotal >= freeDeliveryAbove) ? 0 : 15;
        double totalAmount = subTotal + vat + shipping;

        // Display values on page
        litTotal.Text = currency + subTotal;
        litVat.Text = currency + vat;

        litShipping.Text = (shipping == 0) ? currency + "0" : currency + "15" + " (Add items for " + currency + (freeDeliveryAbove - subTotal) + " or more for free delivery)";
        litTotalAmount.Text = currency + totalAmount;
    }

    private void CreateShopTable(List<Cart> purchaseList, out double subTotal)
    {
        // Generates a table with 2 rows and 4 columns for each type of item in the cart
        subTotal = new Double();
        ProductModel model = new ProductModel();

        foreach (Cart cart in purchaseList)
        {
            Product product = model.GetProduct(cart.ProductID); // Foregin key from the Product table

            // Create the image button
            ImageButton btnImage = new ImageButton
            {
                ImageUrl = string.Format("~/Images/Products/{0}", product.Image),
                PostBackUrl = string.Format("~/Pages/Product.aspx?id={0}", product.ID)
            };


            // Create the delete link
            LinkButton lnkDelete = new LinkButton
            {
                PostBackUrl = string.Format("~/Pages/ShoppingCart.aspx?productId={0}", cart.ID),
                Text = "Delete Item",
                ID = "del" + cart.ID // ID NO1. If you have 2 controls on the same page with the same ID the page will crash, so we added "del" prefix to the first.
            };

            // Add an OnClick Event
            lnkDelete.Click += Delete_Item; // When dinamicly adding events we don't need to add () after the method name!


            // Create the 'Quantity' dropdownlist.
            int[] amount = Enumerable.Range(1, 20).ToArray(); // Generate list with numbers from 1 to 20
            DropDownList ddlAmount = new DropDownList
            {
                DataSource = amount,
                AppendDataBoundItems = true,
                AutoPostBack = true, // After each selection the page will refresh and recalculate the total amount
                ID = cart.ID.ToString() // ID NO2
            };

            ddlAmount.DataBind(); // bind together the Dinamicly generated datasources
            ddlAmount.SelectedValue = cart.Amount.ToString(); // Preselect the item's ordered amount in the cart
            ddlAmount.SelectedIndexChanged += ddlAmount_SelectedIndexChanged; // When dinamicly adding events we don't need to add () after the method name!


            // Create HTML table with 2 rows
            Table table = new Table { CssClass = "cartTable" };
            TableRow a = new TableRow(); // <tr>a</tr>
            TableRow b = new TableRow();

            // Create 6 cells for row a
            TableCell a1 = new TableCell { RowSpan = 2, Width = 50 };
            TableCell a2 = new TableCell { Text = string.Format("<h4>{0}</h4><br/>{1}<br/>In Stock", product.Name, "Item No: " + product.ID), HorizontalAlign = HorizontalAlign.Left, Width = 350 };
            TableCell a3 = new TableCell { Text = "Unit Price<hr/>" };
            TableCell a4 = new TableCell { Text = "Quantity<hr/>" };
            TableCell a5 = new TableCell { Text = "Item Total<hr/>" };
            TableCell a6 = new TableCell { };

            // Create 6 cells for row b
            TableCell b1 = new TableCell {  };
            TableCell b2 = new TableCell { Text = currency + product.Price };
            TableCell b3 = new TableCell {  };
            TableCell b4 = new TableCell { Text = currency + (product.Price * cart.Amount) };
            TableCell b5 = new TableCell { };
            TableCell b6 = new TableCell { };

            // Set 'special' controls
            a1.Controls.Add(btnImage);
            a6.Controls.Add(lnkDelete);
            b3.Controls.Add(ddlAmount);

            // Add cells to rows
            a.Cells.Add(a1);
            a.Cells.Add(a2);
            a.Cells.Add(a3);
            a.Cells.Add(a4);
            a.Cells.Add(a5);
            a.Cells.Add(a6);

            b.Cells.Add(b1);
            b.Cells.Add(b2);
            b.Cells.Add(b3);
            b.Cells.Add(b4);
            b.Cells.Add(b5);
            b.Cells.Add(b6);

            // Add rows to table
            table.Rows.Add(a);
            table.Rows.Add(b);

            // Add table to pnlShoppingCart
            pnlShoppingCart.Controls.Add(table);

            // Add total amount of item in cart to subtotal. Notice that no return keyword needed because is't an out parameter
            subTotal += (cart.Amount * product.Price);
        }

        // Add current user's shopping cart to user specific session value
        Session[User.Identity.GetUserId()] = purchaseList;
    }

    private void ddlAmount_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList selectedList = (DropDownList)sender; // Find out which DropDownList was used
        int quantity = Convert.ToInt32(selectedList.SelectedValue);
        int cartId = Convert.ToInt32(selectedList.ID);

        CartModel model = new CartModel();
        model.UpdateQuantity(cartId, quantity);

        Response.Redirect("~/Pages/ShoppingCart.aspx");
    }

    private void Delete_Item(object sender, EventArgs e)
    {
        LinkButton selectedLink = (LinkButton)sender; // Find out which link button was pressed
        string link = selectedLink.ID.Replace("del", ""); // First remove the "del" prefix
        int cartId = Convert.ToInt32(link);

        CartModel model = new CartModel();
        model.DeleteCart(cartId);

        Response.Redirect("~/Pages/ShoppingCart.aspx");
    }
}