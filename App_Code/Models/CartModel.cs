using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CartModel
/// </summary>
public class CartModel
{
    public string InsertCart(Cart cart)
    {
        try
        {
            GarageEntities db = new GarageEntities();
            db.Carts.Add(cart);
            db.SaveChanges();

            String itm = "s were";
            if (cart.Amount == 1) itm = " was";
            return cart.Amount.ToString() + " item" + itm + " succesfully added to cart";
        }
        catch (Exception e)
        {
            return "Error:" + e;
        }
    }

    public string UpdateCart(int id, Cart cart)
    {
        try
        {
            GarageEntities db = new GarageEntities();

            //Fetch object from db
            Cart p = db.Carts.Find(id);

            p.DatePurchased = cart.DatePurchased;
            p.ClientID = cart.ClientID;
            p.Amount = cart.Amount;
            p.IsInCart = cart.IsInCart;
            p.ProductID = cart.ProductID;

            db.SaveChanges();
            return cart.DatePurchased + " was succesfully updated";

        }
        catch (Exception e)
        {
            return "Error:" + e;
        }
    }

    public string DeleteCart(int id)
    {
        try
        {
            GarageEntities db = new GarageEntities();
            Cart cart = db.Carts.Find(id);

            db.Carts.Attach(cart);
            db.Carts.Remove(cart);
            db.SaveChanges();

            return cart.DatePurchased + "was succesfully deleted";
        }
        catch (Exception e)
        {
            return "Error:" + e;
        }
    }

    public List<Cart> GetOrdersInCart(string userId)
    {
        GarageEntities db = new GarageEntities(); // Connection to the DB
        // A list of not paid items in the cart of the current user
        List<Cart> orders = (from x in db.Carts
                             where x.ClientID == userId
                             && x.IsInCart // Not paid yet
                             orderby x.DatePurchased
                             select x).ToList();

        return orders;
    }

    public int GetAmountOfOrders(string userId)
    {
        // The total number of items in the cart (eg. 2 fan, 3 oil = 5)
        try
        {
            GarageEntities db = new GarageEntities(); // Connection to the DB
            int amount = (from x in db.Carts
                          where x.ClientID == userId
                          && x.IsInCart
                          select x.Amount).Sum();

            return amount;
        }
        catch (Exception)
        {

            return 0;
        }
    }

    public void UpdateQuantity(int id, int quantity)
    {
        GarageEntities db = new GarageEntities(); // Connection to the DB
        Cart cart = db.Carts.Find(id);
        cart.Amount = quantity;

        db.SaveChanges();
    }

    public void MarkOrdersAsPaid(List<Cart> carts)
    {
        GarageEntities db = new GarageEntities(); // Connection to the DB

        if (carts != null)
        {
            foreach (Cart cart in carts)
            {
                Cart oldCart = db.Carts.Find(cart.ID);
                oldCart.DatePurchased = DateTime.Now;
                oldCart.IsInCart = false;
            }

            db.SaveChanges();
        }
    }
}