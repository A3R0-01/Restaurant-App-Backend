import express, { response } from "express";
import mysql from "mysql";
import bodyParser from "body-parser";

const app = express();
const chef = express();
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  next();
});
chef.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  next();
})
chef.use(bodyParser.json())
// app.use(bodyParser.urlencoded({'extended': false}))
app.use(bodyParser.json());
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "bsrvnt",
  database: "rdb",
});

const query = (text, represent, res , defResponse=false) => {
  db.query(text, (err, data)  => {
    if (err) {
      console.log(err)
      console.log(represent)
      return res.json(represent)
    }
    else if (defResponse) {
      console.log(defResponse)
      return res.json(defResponse)
    }
    console.log('dkkddk', data)
    return res.json(data)
  })
}
const verify = (employeeData) => {
  const { id, position, password } = employeeData;
  const query = `select EmployeeId, Position, EmployeePassword from employeestable where EmployeeId = ${id} && EmployeePassword = "${password}" && Position = "${position}"`;
  return db.query(query, (err, data) => {
    if (err) {
      return [
        {
          EmployeeId: null,
          Position: null,
          EmployeePassword: null,
        },
      ];
    }
    return data;
  });
};

app.post("/tables", (req, res) => {
  const { type } = req.body;
  if ( type === "read" ) {
    const text =
      "select t.TableId, t.TableSits, c.ClassName, c.ClassFee from tables t join tableclass c on t.ClassId = c.ClassId WHERE t.TableState = 'IN-SERVICE'; ";
    db.query(text, (err, data) => {
      if (err) {
        return res.json([]);
      }
      return res.json(data);
    });
  }
});

app.post("/menu", (req, res) => {
  const { category, sortColumn } = req.body;
  const finalSort = ['FoodName', 'FoodPrice'][sortColumn]
  let text
  if(category === 0) {
    text = `select * from menu ORDER BY ${finalSort};`;

  } else{
  text = `select * from menu where CategoryId = ${category} ORDER BY ${finalSort};`;
  }
  query(text, 'UNSUCCESSFUL', res)
});

app.post("/order", (req, res) => {
  const { type } = req.body;
  if (type === "foodOrder") {
    FoodOrder(req, res);
  } else if (type === "read/orders") {
    const { CustomerId } = req.body;
    const text = `select o.OrderId, o.OrderStatus, count(*) foodCount, ROUND(sum(c.FoodPrice), 2) totalPrice from 
    (SELECT f.OrderId, f.FoodId, (m.FoodPrice * f.Quantity) FoodPrice from menu m inner join foodorders f on m.FoodId = f.FoodId ) c right outer join orderstable o on o.OrderId = c.OrderId WHERE  o.CustomerId = ${CustomerId} GROUP BY o.OrderId ORDER BY o.OrderId desc;`
    db.query(text, (err, data) => {
      if (err) {
        return res.json("UNSUCCESSFUL");
      }
      console.log(data);
      return res.json(data);
    });
  } else if (type === "read/foodOrders") {
    const { CustomerId, OrderId } = req.body;
    const text = `select f.FoodOrderId, m.FoodName, f.Price, f.Quantity, f.Specification from foodorders f INNER JOIN menu m WHERE f.FoodId = m.FoodId && f.OrderId =${OrderId}`;
    db.query(text, (err, data) => {
      if (err) {
        return res.json([]);
      }
      return res.json(data);
    });
  } else if (type === "EditOrder") {
    const { CustomerId, OrderId, Edit } = req.body;
    const text = `UPDATE orderstable SET OrderStatus = '${Edit}' WHERE OrderId = ${OrderId} && CustomerId = ${CustomerId}`;
    db.query(text, (err, data) => {
      if (err) {
        console.log("edit order error");
        return res.json("UNSUCCESSFUL");
      }
      console.log("edit order successful");
      return res.json("SUCCESSFUL");
    });
  }
});

app.post("/customer", (req, res) => {
  const { type, EmployeeData, tableId, CustomerName } = req.body;
  const status = db.query(
    `select * from customers where TableId = ${tableId} && CustomerStatus='IN-PROGRESS'`,
    (err, data) => {
      if (err) {
        return res.json("nothing");
      } else if (data.length === 1) {
        return res.json(data[0]);
      }else if(type === 'create') {
        const text = `
    insert into customers(CustomerName, TableId, DateArrived, TimeArrived) values("${CustomerName}", ${tableId}, current_date(), current_time());
    `;
        db.query(text, (err, data) => {
          if (err) {
            return res.json("failed to create customer");
          }
        });
        db.query(
          `select * from customers where TableId = ${tableId} && CustomerStatus='IN-PROGRESS'`,
          (err_2, data_2) => {
            if (err_2) {
              return res.json("nothing");
            }
            return res.json(data_2[0]);
          }
        );
      }else{
        return res.json('nothing')
      }
    }
  );
});

app.post('/RequestClearance', (req, res) => {
  const {CustomerId} = req.body
  const text = `Select grand.CustomerId, cst.CustomerName , grand.PriceToPay from (Select orders.CustomerId,sum(combo.TotalPrice) PriceToPay FROM (SELECT f.OrderId, (m.FoodPrice * f.Quantity) TotalPrice from menu m INNER JOIN foodorders f on m.FoodId = f.FoodId) combo INNER JOIN orderstable orders on orders.OrderId = combo.OrderId WHERE orders.OrderStatus = 'CURRENT' && orders.CustomerId = ${CustomerId} GROUP BY orders.CustomerId) grand inner join customers cst on cst.CustomerId = grand.CustomerId;`
  db.query(text, (err, data) => {
    if(err){
      console.log(err)
      return res.json('nothing')
    }else if(data.length < 1){
      return res.json('nothing')
    }
    console.log(data)
    return res.json(data)
  })
})

app.post("/login", (req, res) => {
  const { EmployeeId, Position, EmployeePassword } = req.body;
  const text = `select EmployeeId, Position, EmployeePassword from employeestable where EmployeeId = ${EmployeeId} && EmployeePassword = "${EmployeePassword}" && Position = "${Position}";`;
  db.query(text, (err, data) => {
    if (err || data.length < 1) {
      return res.json("UNSUCCESSFUL");
    }
    // db.query(
    //     `update employeestable set SignedIn = "ACTIVE" where EmployeeId = ${EmployeeId} && EmployeePassword = ${EmployeePassword} && Position = ${Position};`,
    //     (err, data) => {
    //         if (err) {
    //             return res.json({})
    //         }
    //     }
    // )
    return res.json(data);
  });
});

app.post("/categories", (req, res) => {
  const { type} = req.body;
  if (type === "categories/read") {
    const text = "select c.CategoryId, c.CategoryName, count(m.CategoryId) InStock  from categories c left outer join (select * from menu where MenuState = 'IN-SERVICE' && FoodStatus = 'IN-STOCK') m on c.CategoryId = m.CategoryId where c.CategoryState ='IN-SERVICE' group by c.CategoryId  ";
    query(text, 'UNSUCCESSFUL', res)
  } else {
    return res.json([]);
  }
});

app.get("/employees", (req, res) => {
  const text = "select * from employeesTable";
  db.query(text, (err, data) => {
    if (err) {
      return res.json(err);
    }
    return res.json(data);
  });
});

const FoodOrder = (req, res) => {
  const {
    TableId,
    CustomerId,
    FoodId,
    Quantity,
    Specification,
    Price,
    EmployeeId,
  } = req.body;
  console.log(req.body);
  const text = `select OrderId from orderstable where CustomerId = ${CustomerId}  && TableId = ${TableId} && OrderStatus = "CURRENT";`;
  const func = (orderId) => {
    const text_2 = `select FoodOrderId from foodorders where FoodId = ${FoodId} && OrderId = ${orderId} `;
    db.query(text_2, (err, data) => {
      if (err) {
        return res.json("error 3");
      } else if (data.length < 1) {
        const query = `insert into foodorders(FoodId, Quantity,Specification, OrderId, Price) values (${FoodId},${Quantity},"${Specification}", ${orderId}, ${Price})`;
        db.query(query, (err_2, data_2) => {
          if (err_2) {
            return res.json("UNSUCCESSFUL");
          }
          return res.json("SUCCESSFUL");
        });
      } else {
        return res.json("ORDER ALREADY MADE");
      }
    });
  };
  const func_2 = () =>
    db.query(text, (err, data) => {
      if (err) {
        return res.json("error 1");
      } else if (data.length === 0) {
        const text_3 = `insert into orderstable(CustomerId,EmployeeId, TableId, DateInit, TimeInit) VALUES (${CustomerId},${EmployeeId}, ${TableId}, CURRENT_DATE(), CURRENT_TIME());`;
        db.query(text_3, (err_2, data_2) => {
          if (err_2) {
            console.log(err_2);
            return res.json("error insertion");
          }
          func_2();
        });
      } else {
        const orderId = data[0].OrderId;
        console.log(orderId);
        func(orderId);
      }
    });

  func_2();
};

chef.post("/classes", (req, res) => {
  const {type} = req.body
 if(type==='classes/read'){
  const text = "select * from tableclass"
  query(text, [], res)
 }
})
chef.post("/tables", (req, res) => {
  const {type} = req.body
 if(type==='tables/read'){
  const text = "select t.TableId, t.TableSits, c.ClassName, c.ClassFee, c.ClassId from tables t join tableclass c on t.ClassId = c.ClassId WHERE TableState = 'IN-SERVICE'; "
  query(text, [], res)
 }else if(type === 'tables/update'){
  const {TableClass, TableSits, Id} = req.body
  const text = `update tables set ClassId =${TableClass}, TableSits = ${TableSits} WHERE TableId = ${Id} `
  query(text, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
 }else if (type === 'tables/create'){
  const {TableClass, TableSits} = req.body
  const text = `INSERT INTO tables(ClassId, TableSits) VALUES(${TableClass}, ${TableSits})`
  query(text, 'AddTable/UNSUCCESSFUL', res, 'AddTable/SUCCESSFUL')
 }else if(type === 'tables/delete'){
  const {TableId} = req.body
  const text = `UPDATE tables set TableState = 'OUT-OF-SERVICE' WHERE TableId = ${TableId}`
  query(text, 'DeleteTable/UNSUCCESSFUL', res, 'DeleteTable/SUCCESSFUL')
 }
})

chef.post('/categories', (req, res) => {
  const {type} = req.body
  if(type=== 'categories/read'){
      const text = `select c.CategoryId, c.CategoryName, count(m.CategoryId) TotalDishes, c.CategoryState  from categories c left outer join menu m on m.CategoryId = c.CategoryId group by c.CategoryId order by c.CategoryState desc`
      query(text, [], res)
  }else if(type === 'categories/create'){
      const {CategoryName} = req.body
      const text = `INSERT INTO categories(CategoryName) VALUES('${CategoryName}')`
      query(text, 'AddCategory/UNSUCCESSFUL', res, 'AddCategory/SUCCESSFUL')
  }else if(type === 'categories/update'){
    const {CategoryName, CategoryState, Id} = req.body
    const text = `update categories set CategoryName = '${CategoryName}', CategoryState = '${CategoryState}' where CategoryId = ${Id}`
    query(text,'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else if(type==='menu/read'){
    const {CategoryId} = req.body
    const text = `select * from menu where CategoryId = ${CategoryId} order by MenuState desc;`
    query(text, [], res)
  }else if(type === 'menu/update') {
    const {
      Id,
      FoodName,
      FoodPrice,
      FoodDescription,
      FoodStatus, MenuState} = req.body
      const text = `update menu set
      FoodName = "${FoodName}",
      FoodPrice = ${FoodPrice},
      FoodDescription = "${FoodDescription}",
      FoodStatus = "${FoodStatus}",
      MenuState = "${MenuState}"
      where FoodId = ${Id}
      `
      query(text, 'SUCCESSFUL', res, 'UNSUCCESSFUL')
  }else if(type === 'menu/stock-change'){
    const {FoodStatus, Id} = req.body
    const text = `update menu set FoodStatus = "${FoodStatus}" where FoodId = ${Id}`
    query(text, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else if(type === 'menu/create'){
    const { CategoryId, FoodName, FoodDescription, FoodPrice} = req.body
    const text = `insert into menu(FoodName, FoodDescription, FoodPrice, CategoryId) Values('${FoodName}', '${FoodDescription}', ${FoodPrice}, ${CategoryId})`
    query(text, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else if(type === 'menu/delete'){
    const {Id, MenuState} = req.body
    const text = `update menu set MenuState = '${MenuState}' where FoodId = ${Id}`
    query(text, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }
})

chef.post('/orders', (req, res) => {
  const {type} = req.body
  if(type === 'orders/read'){
    const {SortBy} = req.body
    const sortArray = ['o.OrderStatus', 'totalPrice', 'foodCount', 'o.TableId', 'o.OrderId'][SortBy]
    const text = `select o.OrderId, o.TableId, o.OrderStatus, count(*) foodCount, ROUND(sum(c.FoodPrice), 2) totalPrice from 
    (SELECT f.OrderId, f.FoodId, (m.FoodPrice * f.Quantity) FoodPrice from menu m inner join foodorders f on m.FoodId = f.FoodId ) c right outer join orderstable o on o.OrderId = c.OrderId where o.OrderStatus != 'CURRENT'  && o.OrderStatus != 'CANCELLED' GROUP BY o.OrderId ORDER BY ${sortArray};`
    query(text, [], res)
      
  }else if(type === 'foodorders/read'){
    const {OrderId} = req.body
    const text = `select m.FoodName, f.Quantity, f.Specification from foodorders f inner join menu m on m.FoodId = f.FoodId where f.OrderId = ${OrderId}`
    query(text, [], res)
  }else if (type === 'orders/finish'){
    const {Id} = req.body
    const text = `update orderstable set OrderStatus = 'FINISHED' WHERE OrderId=${Id};`
    console.log(text)
    query(text, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }
})
chef.post('/employees', (req, res) => {
  const {type} = req.body
  if(type === 'employees/read'){
    const {Position} = req.body
    const PositionArray = ['MANAGER', 'CHEF', 'WAITER'][Position]
    const text = `select * from employeestable where Position = '${Position}';`
    query(text, 'UNSUCCESSFUL', res)
  }else if (type === 'employees/update'){
    const {
      EmployeeId, EmployeePassword, FirstName, Surname, Salary, Address, Email, NatId
    } = req.body
    const text_2 = `
    update employeestable set
    EmployeePassword = '${EmployeePassword}',
    FirstName = '${FirstName}',
    Surname = '${Surname}',
    Salary = ${Salary},
    Email = '${Email}',
    Address = '${Address}',
    NatId = '${NatId}' where EmployeeId = ${EmployeeId}
    `
    query(text_2, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else if(type === 'employees/status'){
    const {EmployeeId, Status} = req.body
    const editPosition = ['null', 'current_timestamp()'][Status]
    const text_3 = `update employeestable set DateLeft = ${editPosition} where EmployeeId = ${EmployeeId}`
    query(text_3, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else if(type === 'employees/addStaff'){
    const {
      EmployeePassword, FirstName, Surname, Salary, Address, Email, NatId, Position
    } = req.body
    const positionValue = ['MANAGER', 'CHEF', 'WAITER'][Position]
    const text_4 = `
    insert into employeestable(FirstName, Surname, Salary, Address, Email, NatId, Position, EmployeePassword) 
    values(
      '${FirstName}', '${Surname}', ${Salary}, '${Address}', '${Email}','${NatId}', '${positionValue}', '${EmployeePassword}'
    )
    `
    query(text_4, 'UNSUCCESSFUL', res, 'SUCCESSFUL')
  }else{
    req.json('UNSUCCESSFUL')
  }
})
app.listen(8000, () => {
  console.log("waiter server is running");
  db.query(
    'update employeestable set SignedIn = "NOT ACTIVE" where SignedIn = "ACTIVE";',
    (err, data) => {
      if (err) {
        console.log(err);
      }
    }
  );
});
chef.listen(8001, () => console.log('chef server is running'))
