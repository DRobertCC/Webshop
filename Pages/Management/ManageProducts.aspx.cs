using System;
using System.Collections;
using System.IO;
using System.Web.UI.WebControls;

public partial class Pages_Management_ManageProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetImages();

            // Check if the url contains an id parameter = a product is being updated
            if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                FillPage(id);
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ProductModel productModel = new ProductModel();
        Product product = CreateProduct();

        // Check if the url contains an id parameter = a product is being updated
        if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            // ID exists -> Update existing row
            int id = Convert.ToInt32(Request.QueryString["id"]);
            lblResult.Text = productModel.UpdateProduct(id, product);
        }
        else
        {
            // ID does not exist -> Create a new row
            lblResult.Text = productModel.InsertProduct(product);
        }
    }

    private void FillPage(int id)
    {
        try
        {
            // Get selected product from DB
            ProductModel productModel = new ProductModel();
            Product product = productModel.GetProduct(id);

            // Fill the Textboxes
            txtDescription.Text = product.Description;
            txtName.Text = product.Name;
            txtPrice.Text = product.Price.ToString();

            // Set dropdownlist values
            ddlImage.SelectedValue = product.Image;
            ddlType.SelectedValue = product.TypeID.ToString();

            imgImage.ImageUrl = string.Format("~/Images/Products/{0}", product.Image);
        }
        catch (Exception ex)
        {
            lblResult.Text = ex.ToString();
        }
    }

    private void GetImages()
    {
        try
        {
            ddlImage.Items.Clear();
            //Get all filepaths
            string[] images = Directory.GetFiles(Server.MapPath("~/Images/Products/"));

            //Get all filenames and add them to an arraylist
            ArrayList imageList = new ArrayList();
            foreach (string image in images)
            {
                string imageName = image.Substring(image.LastIndexOf(@"\", StringComparison.Ordinal) + 1);
                imageList.Add(imageName);
            }

            //Set the arrayList as the dropdownview's datasource and refresh
            ddlImage.DataSource = imageList;
            ddlImage.AppendDataBoundItems = true;
            ddlImage.DataBind();
        }
        catch (Exception e)
        {
            lblResult.Text = e.ToString();
        }
    }

    private Product CreateProduct()
    {
        Product product = new Product();

        product.Name = txtName.Text;
        product.Price = Convert.ToDouble(txtPrice.Text);
        product.TypeID = Convert.ToInt32(ddlType.SelectedValue);
        product.Description = txtDescription.Text;
        product.Image = ddlImage.SelectedValue;

        return product;
    }

    protected void Upload(object sender, EventArgs e)
    {
        if (fuImportImage.HasFile)
        {
            string fileName = Path.GetFileName(fuImportImage.PostedFile.FileName);
            fuImportImage.PostedFile.SaveAs(Server.MapPath("~/Images/Products/") + fileName);
            GetImages();
            ddlImage.SelectedValue = fileName;
            imgImage.ImageUrl = "~/Images/Products/" + ddlImage.SelectedItem.Value;
        }
    }

    protected void ddlImage_SelectedIndexChanged(object sender, EventArgs e)
    {
        imgImage.ImageUrl = "~/Images/Products/" + ddlImage.SelectedItem.Value;
    }
}