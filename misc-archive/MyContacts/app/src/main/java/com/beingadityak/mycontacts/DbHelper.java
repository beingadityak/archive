package com.beingadityak.mycontacts;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Aditya Krishnakumar on 26-06-2016.
 */
public class DbHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "contactsdb";
    private static final int DATABASE_VERSION = 1;
    private static final String TABLE_NAME = "contacts";

    private static final String COL_ID = "id";
    private static final String COL_NAME = "name";
    private static final String COL_NUM = "number";
    private static final String COL_NUM2 = "number2";
    private static final String COL_EMAILID = "emailid";

    private String name;
    private String no;
    private String no2;
    private String email;

    SQLiteDatabase database;

    public DbHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_ITEM_TABLE = "CREATE TABLE "+TABLE_NAME+" ("+COL_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, "+COL_NAME+" TEXT NOT NULL, "+COL_NUM+" TEXT NOT NULL, "+COL_NUM2+" TEXT DEFAULT '', "+COL_EMAILID+" TEXT NOT NULL)";
        db.execSQL(CREATE_ITEM_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS "+TABLE_NAME);
        onCreate(db);
    }

    public int insertValues()
    {
        database = this.getWritableDatabase();
        ContentValues values1 = new ContentValues();
        values1.put(COL_NAME,name);
        values1.put(COL_NUM,no);
        values1.put(COL_NUM2,no2);
        values1.put(COL_EMAILID,email);
        int rows_affected = (int) database.insert(TABLE_NAME,null,values1);
        database.close();
        return rows_affected;
    }

    public void setName(String name)
    {
        this.name = name;
    }
    public void setNo(String no)
    {
        this.no = no;
    }
    public void setNo2(String no2)
    {
        this.no2 = no2;
    }
    public void setEmail(String email)
    {
        this.email = email;
    }

    public List<String> fetchData(String name)
    {
        ArrayList<String> data = new ArrayList<String>();
        String selectQuery = "SELECT * FROM "+TABLE_NAME+" WHERE "+COL_NAME+" = ?";
        database = this.getReadableDatabase();

        Cursor cursor = database.rawQuery(selectQuery,new String[]{name});
        if(cursor.moveToFirst())
        {
            do
            {
                data.add(cursor.getString(2));
                data.add(cursor.getString(3));
                data.add(cursor.getString(4));
            }while(cursor.moveToNext());
        }
        cursor.close();
        database.close();
        return data;
    }

    public List<String> fetchNames()
    {
        ArrayList<String> data = new ArrayList<String>();
        String selectQuery = "SELECT * FROM "+TABLE_NAME;
        database = this.getReadableDatabase();

        Cursor cursor = database.rawQuery(selectQuery,null);
        if(cursor.moveToFirst())
        {
            do
            {
                data.add(cursor.getString(1));
            }while(cursor.moveToNext());
        }
        cursor.close();
        database.close();
        return data;
    }

    public int updateData(String oldname,String name, String no, String no2, String email)
    {
        database = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("name",name);
        values.put("number",no);
        values.put("number2",no2);
        values.put("emailid",email);
        int count = database.update(TABLE_NAME,values,COL_NAME+" = ?",new String[]{oldname});
        database.close();
        return count;
    }

    public int deleteData(String delname)
    {
        database = this.getWritableDatabase();
        int count = database.delete(TABLE_NAME,COL_NAME+" = ?",new String[]{delname});
        database.close();
        return count;
    }
}
