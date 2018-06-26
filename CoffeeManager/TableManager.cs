using CoffeeManager.DAO;
using CoffeeManager.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static CoffeeManager.AccountProfile;

namespace CoffeeManager
{
    public partial class TableManager : Form
    {
        private Account loginAccount;

        public Account LoginAccount
        {
            get => loginAccount;
            set { loginAccount = value; ChangeAccount(loginAccount.Type); }
        }

        public TableManager(Account acc)
        {
            InitializeComponent();
            this.LoginAccount = acc;
            LoadTable();
            LoadCategory();
            LoadComboboxTable(cbSwitchTable);
        }
        #region Methods
        void ChangeAccount(int type)
        {
            adminToolStripMenuItem.Enabled = type == 1;
            thôngTinTàiKhoảnToolStripMenuItem.Text += " (" + LoginAccount.DisplayName + ")";
        }
        void LoadCategory()
        {
            List<Category> listCategory = CategoryDAO.Instance.GetListCategory();
            cbCategory.DataSource = listCategory;
            cbCategory.DisplayMember = "Name";//hiển thị trường Name
        }
        void LoadFoodByCategoryID(int id)
        {
            List<Food> listFood = FoodDAO.Instance.GetFoodByCategoryID(id);
            cbFood.DataSource = listFood;
            cbFood.DisplayMember = "Name";//hiển thị trường Name
        }
        void LoadTable()
        {
            flpTable.Controls.Clear();
            List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach (Table item in tableList)
            {
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + item.Status;

                btn.Click += btn_Click;
                btn.Tag = item;
                
                if (item.Status == "Trống") btn.BackColor = Color.Gainsboro;
                else btn.BackColor = Color.PowderBlue;

                flpTable.Controls.Add(btn);
            }
            txtTotalPrice.BackColor = Color.WhiteSmoke;
        }
        void ShowBill(int id)
        {
            lsvBill.Items.Clear();
            List<DTO.Menu> listBillInfor = MenuDAO.Instance.GetListMenuByTable(id);

            float totalPirce = 0;


            foreach (DTO.Menu item in listBillInfor)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPrice.ToString());
                totalPirce += item.TotalPrice;
                lsvBill.Items.Add(lsvItem);
            }
            CultureInfo cuture = new CultureInfo("en-US");// chuyển đơn vị tiền tệ
                                                          //CultureInfo cuture = new CultureInfo("vi-VN"); //tiền việt 

            txtTotalPrice.Text = totalPirce.ToString("c", cuture);
        }
        void LoadComboboxTable(ComboBox cb)
        {
            cb.DataSource = TableDAO.Instance.LoadTableList();
            cb.DisplayMember = "Name";
        }

        #endregion

        #region Events
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AccountProfile a = new AccountProfile(loginAccount);
            a.UpdateAccount += a_UpdateAccount;
            a.ShowDialog();

        }
        void a_UpdateAccount(object sender, AccountEvent e)
        {
            thôngTinCáNhânToolStripMenuItem.Text="Thông tin tài khoản ("+e.Acc.DisplayName+")";
        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Admin admin = new Admin();
            admin.InsertFood += admin_InsertFood;
            admin.DeleteFood += admin_DeleteFood;
            admin.UpdateFood += admin_UpdateFood;
            admin.ShowDialog();
        }

        private void admin_UpdateFood(object sender, EventArgs e)
        {
            LoadFoodByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
        }

        private void admin_DeleteFood(object sender, EventArgs e)
        {
            LoadFoodByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadTable();
        }

        private void admin_InsertFood(object sender, EventArgs e)
        {
            LoadFoodByCategoryID((cbCategory.SelectedItem as Category).ID);
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
        }

        private void btn_Click(object sender, EventArgs e) // click to showbill
        {
            int tableID = ((sender as Button).Tag as Table).ID;
            lsvBill.Tag = (sender as Button).Tag;
            ShowBill(tableID);
        }

        private void TableManager_Load(object sender, EventArgs e)
        {

        }


        private void lsvBill_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e) // khi thay đổi Category
        {
            int id = 0;

            ComboBox cb = sender as ComboBox;
            if (cb.SelectedItem == null) return;
            Category slected = cb.SelectedItem as Category;
            id = slected.ID;

            LoadFoodByCategoryID(id);
        }

        private void btnAddFood_Click(object sender, EventArgs e)
        {
            Table table = lsvBill.Tag as Table;

            if (table == null){ MessageBox.Show("Hãy chọn bàn"); return; }

            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID);
            int idFood = (cbFood.SelectedItem as Food).ID;
            int count = (int)nmFoodCount.Value;

            if (idBill == -1)
            {
                BillDAO.Instance.InsertBill(table.ID);
                BillInforDAO.Instance.InsertBillInfor(BillDAO.Instance.GetMaxIDBill(), idFood, count);
            }
            else
            {
                BillInforDAO.Instance.InsertBillInfor(idBill, idFood, count);
            }

            ShowBill(table.ID);
            LoadTable();
        }
       

        private void flpTable_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            Table table = lsvBill.Tag as Table;
            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID);

            int discount = (int)nmDiscount.Value;

            string temp = txtTotalPrice.Text.Remove(0,1);
            double totalPrice =Convert.ToDouble(temp);

            double finalTotalPrice = totalPrice - (totalPrice / 100) * discount;

            if (idBill != -1)
                if (MessageBox.Show(String.Format("Thanh toán hoá đơn cho bàn {0}\n Tổng tiền - (Tổng tiền / 100) x Giảm giá => {1} - ({1} / 100) x {2} = {3}", table.Name,totalPrice,discount,finalTotalPrice), "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill,discount,(float)finalTotalPrice);
                    ShowBill(table.ID);
                    LoadTable();
                }
        }

        private void btnSwitchTable_Click(object sender, EventArgs e)
        {           
            int id1 = (lsvBill.Tag as Table).ID;
            int id2 = (cbSwitchTable.SelectedItem as Table).ID;
            if (MessageBox.Show(string.Format("Chuyển từ bàn {0} sang {1}", (lsvBill.Tag as Table).Name, (cbSwitchTable.SelectedItem as Table).Name), "Thông báo", MessageBoxButtons.OKCancel)==System.Windows.Forms.DialogResult.OK)
            {
                TableDAO.Instance.SwitchTable(id1, id2);
                LoadTable();
            }
        }
        #endregion

        private void thôngTinTàiKhoảnToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
    }
}
