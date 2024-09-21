import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class Database_Controller{

  Database_Controller._();
  static Database_Controller database_controller = Database_Controller._();


  String databaseName = 'Products';
  String Directorypath = getApplicationDocumentsDirectory().toString();
  late Database db;

  Future<void> CreateDatabase() async{
    String path = join(Directorypath, databaseName);
    db = await openDatabase(path);
    String quary = "CREATE TABLE IF NOT EXISTS Products(id INTEGER AUTO INCREMENT PRIMARY KEY, Name VARCHAR, Price VARCHAR,Category VARCHAR)";
    await db.execute(quary);
  }

  Future<int> AddProduct({required String Name,required String Price,required String Catagory}){
    CreateDatabase();
    String quary = 'INSERT INTO Products (Name,Price,Category) VALUES (?,?,?)';
    List args=[Name,Price,Catagory];
    Future<int> result = db.rawInsert(quary, args);
    print(result.toString());
    return result;
  }
  Future<List<Map<String,dynamic>>> FetchAllProducts (){
    CreateDatabase();
    String quary = 'SELECT *FROM products';
    var result =db.rawQuery(quary);
    return result;
  }
  Future<int> UpdateProductDetail ({required String Name,required String Price,required String Catagory,required int Id}){
    CreateDatabase();
    String quary = 'UPDATE Products(Name,Price,Category) SET ?,?,? WHERE id =?';
    List args= [Name, Price, Catagory,Id];
    var result = db.rawUpdate(quary,args);
    return result;
  }
  Future<int> DeleteProduct ({required int id}){
    CreateDatabase();
    String quary = 'DELETE FROM Products WHERE id = ?';
    List args = [id];
    var result = db.rawDelete(quary,args);

    return result;
  }
}