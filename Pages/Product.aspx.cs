﻿using System;
using System.Linq;

public partial class Pages_Product : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FillPage();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        // Check if a productId parameter exist in the URL
        if (!string.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            string clientId = "-1";
            int id = Convert.ToInt32(Request.QueryString["id"]); // Retrieving the value of the Id parameter from the URL
            int amount = Convert.ToInt32(ddlAmount.SelectedValue);// Retrieving the value of the amount parameter from the Dropdown list

            Cart cart = new Cart
            {
                Amount = amount,
                ClientID = clientId,
                DatePurchased = DateTime.Now,
                IsInCart = true,
                ProductID = id
            };

            CartModel model = new CartModel();
            lblResult.Text = model.InsertCart(cart);
        }
    }

    private void FillPage()
    {
        // Get selected product data
        if (!string.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            ProductModel model = new ProductModel();
            Product product = model.GetProduct(id);

            // Fill page with data
            lblTitle.Text = product.Name;
            lblDescription.Text = product.Description;
            lblPrice.Text = "Price per unit:<br/>£ " + product.Price;
            imgProduct.ImageUrl = "~/Images/Products/" + product.Image;
            lblItemNr.Text = product.ID.ToString();

            // Fill amount list with numbers 1-20
            int[] amount = Enumerable.Range(1, 20).ToArray();
            ddlAmount.DataSource = amount;
            ddlAmount.AppendDataBoundItems = true;
            ddlAmount.DataBind();
        }
    }
}