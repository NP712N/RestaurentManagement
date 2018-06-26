using CoffeeManager.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeeManager.DAO
{
    public class MenuDAO
    {
        static MenuDAO instance;

        public static MenuDAO Instance
        {
            get { if (instance == null) instance = new MenuDAO();return MenuDAO.instance; }
            private set { MenuDAO.instance = value; }
        }
        MenuDAO() { }

        public List<Menu> GetListMenuByTable(int id) // lấy hoá đơn từ bàn 
        {
            List<Menu> listMenu = new List<Menu>();
            string query = "select f.name,bi.count,f.price,f.price*bi.count as totalPrice From BillInfor bi,Bill b, Food f  where bi.idBill = b.id and bi.idFood = f.id and b.status = 0 and  b.idTable = "+ id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Menu menu = new Menu(item);
                listMenu.Add(menu);
            }

            return listMenu;
        }
    }
}
