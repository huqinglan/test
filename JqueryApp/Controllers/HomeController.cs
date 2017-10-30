using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.Mvc;

namespace JqueryApp.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {

        #region JQuery 基本应用

        public ActionResult Index()
        {
            ViewData["Title"] = "JQuery 基本应用";
            return View();
        }

        public ActionResult ReadValue()
        {
            ViewData["Title"] = "JQuery 读取组件值";
            return View();
        }

        public ActionResult SetValue()
        {
            ViewData["Title"] = "JQuery 给组件赋值";
            return View();
        }
        #endregion

        #region JQuer常用组件

        public ActionResult IndexComponents()
        {
            ViewData["Title"] = "JQuer常用组件";
            return View();
        }

        #endregion

        #region JQuery & Asp.net MVC 数据交互演示
        /// <summary>
        /// JQuery & Asp.net MVC 数据交互演示
        /// </summary>
        /// <returns></returns>
        public ActionResult IndexData()
        {
            ViewData["Title"] = "JQuery & Asp.net MVC 数据交互演示";
            return View();
        }

        #region 表单验证

        /// <summary>
        /// JQuery表单验证演示
        /// </summary>
        /// <returns></returns>
        public ActionResult FormValidation()
        {
            ViewData["Title"] = "JQuery表单验证演示";
            return View();
        }

        #endregion

        #region 权型表格

        public ActionResult TreeTable()
        {
            ViewData["Title"] = "Tree型表格应用";
            DataSet ds = SQLiteHelper.Query("SELECT id, parent_id, title, status, kind,path FROM category ORDER BY (path || id)");
            return View(DataTableToList(ds.Tables[0]));
        }

        /// <summary>
        /// 创建分类
        /// </summary>
        /// <param name="title"></param>
        /// <param name="status"></param>
        /// <param name="kind"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateCategory(string title, string status, string kind)
        {
            if (SQLiteHelper.ExecuteSql("INSERT INTO category (title, status, kind) VALUES ('" + title + "', '" + status + "', '" + kind + "')") > 1)
                return Content("true");
            else
                return Content("false");
        }

        /// <summary>
        /// 读取记录信息
        /// </summary>
        /// <param name="id">记录ID</param>
        /// <returns></returns>
        public ActionResult GetCategory(int? id)
        {
            DataSet ds = SQLiteHelper.Query("SELECT id, parent_id, title, status, kind, path FROM category WHERE id=" + id);
            return Json(JsonHelper.CreateJson(ds.Tables[0], "category"));
            //return Json(JsonHelper.DataTableToJSON(ds.Tables[0], "category"));
        }

        /// <summary>
        /// 修改保存分类
        /// </summary>
        /// <param name="title"></param>
        /// <param name="status"></param>
        /// <param name="kind"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SaveCategory(int id, string title, string status, string kind)
        {
            if (SQLiteHelper.ExecuteSql("UPDATE category SET title='" + title + "', status='" + status + "', kind='" + kind + "' WHERE id=" + id) > 1)
                return Content("true");
            else
                return Content("false");
        }

        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult TreeTableDelete(int id)
        {
            if (SQLiteHelper.ExecuteSql("DELETE FROM category WHERE id=" + id) > 1)
                return Content("true");
            else
                return Content("false");
        }

        /// <summary>
        /// 移动记录
        /// </summary>
        /// <param name="id">ID</param>
        /// <param name="pid">目标ID</param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult TreeTableMove(string id, string pid)
        {
            int p1 = int.Parse(id.Replace("node-", ""));
            int p2 = int.Parse(pid.Replace("node-", ""));
            if (p1 != p2)//判断ID与父级ID相同
            {
                if (SQLiteHelper.ExecuteSql("UPDATE category SET parent_id =" + p2.ToString() + " WHERE id =" + p1.ToString()) > 1)
                    return Content("true");
                else
                    return Content("false");
            }
            else
                return Content("false");
        }

        public List<Models.category> DataTableToList(DataTable dt)
        {
            List<Models.category> modelList = new List<Models.category>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Models.category model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Models.category();
                    if (dt.Rows[n]["id"].ToString() != "")
                    {
                        model.id = int.Parse(dt.Rows[n]["id"].ToString());
                    }
                    if (dt.Rows[n]["parent_id"].ToString() != "")
                    {
                        model.parent_id = int.Parse(dt.Rows[n]["parent_id"].ToString());
                    }

                    model.title = dt.Rows[n]["title"].ToString();
                    model.kind = dt.Rows[n]["kind"].ToString();
                    model.status = dt.Rows[n]["status"].ToString();
                    model.path = dt.Rows[n]["path"].ToString();
                    modelList.Add(model);
                }
            }
            return modelList;
        }

        #endregion

        #region 目录树

        public ActionResult TreeView()
        {
            DataSet ds = SQLiteHelper.Query("SELECT id, parent_id, title, status, kind, path FROM category");
            TreeView tree = new TreeView();
            ViewData["TreeView"] = tree.CreateTree(ds.Tables[0],0);

            return View();
        }

        #endregion

        #endregion

        public ActionResult About()
        {
            ViewData["Title"] = "关于我们";
            return View();
        }
    }
}
