using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;

namespace JqueryApp
{
    /// <summary>
    /// 一个通用的树状菜单类
    /// </summary>
    public class TreeView
    {
        private string _treeHtml = "<ul id='navigation' class='filetree'>";
        private DataTable _dataTable;

        /// <summary>
        /// 根据DataTable对象，生成一棵树
        /// </summary>
        /// <param name="dataTable">树中节点的数据</param>
        /// <returns>树的HTML代码</returns>
        public string CreateTree(DataTable dataTable,int expleve)
        {
            this._dataTable = dataTable;
            this.CreateSubTree(0,expleve);
            return _treeHtml + "</ul>";
        }

        /// <summary>
        /// 获取父节点编号为ParentNoId的所有节点，并用DataTable返回
        /// </summary>
        /// <param name="ParentNoId">父节点编号</param>
        /// <returns>DataTable形式的所有孩子节点数据</returns>
        private DataTable GetChilds(int parent_id)
        {
            DataTable childNodes = new DataTable();
            childNodes = this._dataTable.Clone();

            foreach (DataRow dr in this._dataTable.Rows)
            {
                if (Convert.ToInt32(dr["parent_id"]) == parent_id)
                {
                    childNodes.ImportRow(dr);
                }
            }

            return childNodes;
        }

        /// <summary>
        /// 判断编号为NoId的节点是否为叶子节点
        /// </summary>
        /// <param name="NoId">待判断的节点编号</param>
        /// <returns>是叶子节点：返回true；否则：返回false</returns>
        private bool IsLeaf(int id)
        {
            foreach (DataRow dr in this._dataTable.Rows)
                if (Convert.ToInt32(dr["parent_id"]) == id)
                    return false;
            return true;
        }

        /// <summary>
        /// 得到编号为NoId的节点的父节点编号
        /// </summary>
        /// <param name="NoId">节点编号</param>
        /// <returns>父节点编号</returns>
        private int GetParent(int id)
        {
            foreach (DataRow dr in this._dataTable.Rows)
                if (Convert.ToInt32(dr["id"]) == id)
                    return Convert.ToInt32(dr["parent_id"]);
            return -1;

        }

        /// <summary>
        /// 得到编号为NoId的节点的级别，根节点为0
        /// </summary>
        /// <param name="NoId">待计算的巨额电编号</param>
        /// <returns>节点的级别，根节点为0</returns>
        private int GetLevel(int id)
        {
            int parent_id = GetParent(id);
            if (parent_id == 0) return 1;
            else
                return GetLevel(parent_id) + 1;    //递归
        }

        /// <summary>
        /// 递归生成根编号为NoId的树
        /// </summary>
        /// <param name="NoId">所要生成子树的根节点</param>
        private void CreateSubTree(int id,int expleve)
        { 
            DataTable childNodes = this.GetChilds(id);    //获取根节点的所有孩子

            //循环生成根节点的所有孩子对应的HTML
            int childId = 0;

            foreach (DataRow dr in childNodes.Rows)
            {
                childId = Convert.ToInt32(dr["id"]);
                
                //如果该孩子是叶子节点，则生成其HTML代码
                if (this.IsLeaf(childId))
                {
                    this._treeHtml += "<ul><li><span class='file'>" + dr["title"] + "</span></li></ul>";
                }
                //如果该孩子为中间节点，则首先构造其HTML，然后递归生成其所有孩子的HTML
                else
                {
                    if (dr["parent_id"].ToString() == "0")
                    {
                        this._treeHtml += "<li class='open'><span class='folder'>" + dr["title"] + "</span>";
                        this.CreateSubTree(childId, expleve);//递归
                        this._treeHtml += "</li>";
                    }
                    else
                    {
                   
                        this._treeHtml += "<ul><li><span class='folder'>" + dr["title"] + "</span>";
                        this.CreateSubTree(childId, expleve);//递归
                        this._treeHtml += "</li></ul>";
                    }
                }

            }
        }
    }
}
