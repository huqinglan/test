using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace JqueryApp
{
    public class DSHelper
    {
        public DSHelper()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        public static string connstring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + System.Web.HttpContext.Current.Server.MapPath("~/App_Data/test.mdb");

        public static DataSet GreatDs(string sql)
        {
            OleDbDataAdapter Dar = new OleDbDataAdapter(sql, connstring);

            DataSet ds = new DataSet();
            Dar.Fill(ds);
            return ds;
        }

        public static void RunSql(string sql)
        {
            OleDbConnection conn = new OleDbConnection();//创建连接对象
            conn.ConnectionString = connstring;//给连接字符串赋值
            conn.Open();//打开数据库
            OleDbCommand cmd = new OleDbCommand(sql, conn);
            cmd.ExecuteNonQuery();//
            conn.Close();//关闭数据库
        }
    }
}
