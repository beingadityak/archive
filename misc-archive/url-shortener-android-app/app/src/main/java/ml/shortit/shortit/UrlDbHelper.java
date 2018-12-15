/*
 * MIT License
 *
 * Copyright (c) 2016 Aditya Krishnakumar
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package ml.shortit.shortit;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Aditya on 12-09-16.
 */
public class UrlDbHelper extends SQLiteOpenHelper{

    private static final String DB_NAME = "links_db";
    private static final int VERSION = 1;
    private static final String TABLE_NAME = "websites";

    private static final String COL_ID = "id";
    private static final String COL_SHORT_URL = "short_url";
    private static final String COL_LONG_URL = "long_url";
    SQLiteDatabase database;
    private String shortUrl;
    private String longUrl;

    public UrlDbHelper(Context context) {
        super(context, DB_NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_ITEM_TABLE = "CREATE TABLE "+TABLE_NAME+" ("+COL_ID+" INTEGER PRIMARY KEY AUTOINCREMENT, "+COL_SHORT_URL+" TEXT NOT NULL, "+COL_LONG_URL+" TEXT NOT NULL, UNIQUE("+COL_SHORT_URL+", "+COL_LONG_URL+") ON CONFLICT REPLACE)";
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
        ContentValues values = new ContentValues();
        values.put(COL_SHORT_URL,shortUrl);
        values.put(COL_LONG_URL,longUrl);
        int rows_affected = (int) database.insert(TABLE_NAME,null,values);
        database.close();
        return rows_affected;
    }

    public void setShortUrl(String shortUrl)
    {
        this.shortUrl = shortUrl;
    }
    public void setLongUrl(String longUrl)
    {
        this.longUrl = longUrl;
    }

    public List<String> fetchData(String shortUrl)
    {
        ArrayList<String> data = new ArrayList<String>();
        String selectQuery = "SELECT "+COL_LONG_URL+" FROM "+TABLE_NAME+" WHERE "+COL_SHORT_URL+" = ?";
        database = this.getReadableDatabase();
        Cursor cursor = database.rawQuery(selectQuery,new String[]{shortUrl});
        if(cursor.moveToFirst())
        {
            do {
                data.add(cursor.getString(0));
            }while(cursor.moveToNext());
        }
        cursor.close();
        database.close();
        return data;
    }

    public List<String> fetchShortUrls()
    {
        database = this.getReadableDatabase();
        ArrayList<String> data = new ArrayList<String>();
        String selectQuery = "SELECT * FROM "+TABLE_NAME;
        Cursor cursor = database.rawQuery(selectQuery,null);
        if(cursor.moveToFirst())
        {
            do{
                data.add(cursor.getString(1));
            }while(cursor.moveToNext());
        }
        cursor.close();
        database.close();
        return data;
    }

    public int deleteData(String shortUrlName) {
        database = this.getWritableDatabase();
        int count = database.delete(TABLE_NAME, COL_SHORT_URL + " = ?", new String[]{shortUrlName});
        database.close();
        return count;
    }

    public void wipeData() {
        database = this.getWritableDatabase();
        database.delete(TABLE_NAME, null, null);
        database.close();
    }
}
