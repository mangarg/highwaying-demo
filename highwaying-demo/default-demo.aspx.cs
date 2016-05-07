using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace highwaying_demo
{
    public partial class default_demo : System.Web.UI.Page
    {

        private string connectionString = WebConfigurationManager.ConnectionStrings["Highway"].ConnectionString;
        // private string selectSQL;

        protected void Page_Load(object sender, EventArgs e)
        {
            //  lstAuthor.Items.Clear();
            // string selectSQL = "SELECT au_lname, au_fname, au_id FROM Authors";

            // SqlConnection con = new SqlConnection(connectionString);
            // con.Open();

            // Response.Write ("Connection state = " + con.State);
            // SqlCommand cmd = new SqlCommand(selectSQL, con);
            // SqlDataReader reader;
            DropDownList1.Visible = false;
            LoadHighwayList();

            DropDownHighwayList.SelectedIndexChanged += new EventHandler(DropDownHighwayList_SelectedIndexChanged);
            if (!IsPostBack) { 
            DropDownHighwayList.Attributes.Add("onchange", "GetRoute();");
        }

        }


      


        private void LoadHighwayList()
        {
            if (!IsPostBack) { 
            SqlConnection con = new SqlConnection(connectionString);
            string com = "Select highwaysection, startpoint + '|' + endpoint as oneadd from tblhighwaymaster";
            SqlDataAdapter adpt = new SqlDataAdapter(com, con);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            DropDownHighwayList.DataSource = dt;
                DropDownHighwayList.DataBind();
                DropDownHighwayList.DataTextField = "highwaysection";
                DropDownHighwayList.DataValueField = "oneadd";
                DropDownHighwayList.DataBind();
                DropDownHighwayList.Items.Insert(0, new ListItem("--Select--", "0"));
        }

           
          

        }

      

        protected void DropDownHighwayList_SelectedIndexChanged(object sender, EventArgs e)
        {
           // Response.Write("test test ");

            /*
                        DropDownList1.Visible = true;
                        SqlConnection con1 = new SqlConnection(connectionString);
                        string com1 = "Select * from tblsectionmaster where highwayid=" + DropDownHighwayList.SelectedValue;
                        SqlDataAdapter adpt1 = new SqlDataAdapter(com1, con1);
                        DataTable dt1 = new DataTable();
                        adpt1.Fill(dt1);
                        DropDownList1.DataSource = dt1;
                        DropDownList1.DataBind();
                        DropDownList1.DataTextField = "sectionpoint";
                        DropDownList1.DataValueField = "ID";
                        DropDownList1.DataBind();
                        DropDownList1.Items.Insert(0, new ListItem("--Select--", "0"));
                        DropDownList1.Visible = false;

            */



           // ScriptManager.RegisterStartupScript(this, GetType(), "GetRoute", "GetRoute()", true);


        }





    }
}