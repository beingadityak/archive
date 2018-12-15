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

import android.app.AlertDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    ArrayList<String> data;
    ListView shortUrlList;
    TextView emptytext;
    FloatingActionButton newUrl;
    UrlDbHelper helper;
    ArrayAdapter<String> dataAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        shortUrlList = (ListView) findViewById(R.id.listView);
        try {
            emptytext = (TextView) findViewById(R.id.textView6);
            emptytext.setText("No Short URLs found. Create One !");
        } catch (Exception e) {
            e.printStackTrace();
        }
        shortUrlList.setEmptyView(emptytext);
        loadDataInList();

        shortUrlList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String urlToOpen = shortUrlList.getItemAtPosition(position).toString();
                Intent browser = new Intent(Intent.ACTION_VIEW);
                browser.setData(Uri.parse(urlToOpen));
                startActivity(browser);
            }
        });

        registerForContextMenu(shortUrlList);

        newUrl = (FloatingActionButton) findViewById(R.id.addUrl);

        newUrl.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent add = new Intent(getApplicationContext(), AddActivity.class);
                startActivity(add);
                finish();
            }
        });
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        menu.setHeaderTitle("URL Actions");
        menu.add(0, v.getId(), 0, "Delete");
        menu.add(0, v.getId(), 0, "Copy URL");
        menu.add(0, v.getId(), 0, "View Details");
        menu.add(0, v.getId(), 0, "Share URL");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
        String shortUrl = ((TextView) info.targetView).getText().toString();

        if (item.getTitle() == "Delete") {
            helper = new UrlDbHelper(getApplicationContext());
            int cnt = helper.deleteData(shortUrl);
            if (cnt > 0) {
                Toast.makeText(MainActivity.this, "Short IT URL Deleted Successfully !", Toast.LENGTH_LONG).show();
                refreshList();
            }
        } else if (item.getTitle() == "Copy URL") {
            ClipboardManager clipboard = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);
            ClipData clip = ClipData.newPlainText("url", shortUrl);
            clipboard.setPrimaryClip(clip);
            Toast.makeText(getApplicationContext(), "URL Copied Successfully !", Toast.LENGTH_LONG).show();
        } else if (item.getTitle() == "View Details") {
            Intent urlView = new Intent(getApplicationContext(), UrlViewActivity.class);
            urlView.putExtra("shortUrl", shortUrl);
            startActivity(urlView);
            finish();
        } else if (item.getTitle() == "Share URL") {
            Intent sendIntent = new Intent();
            sendIntent.setAction(Intent.ACTION_SEND);
            sendIntent.putExtra(Intent.EXTRA_TEXT, "Check This Out : " + shortUrl + "\n\n  - Shared Via Short IT App");
            sendIntent.setType("text/plain");
            startActivity(sendIntent);
        } else {
            return false;
        }
        return true;
    }

    private int loadDataInList() {
        helper = new UrlDbHelper(getApplicationContext());
        data = (ArrayList<String>) helper.fetchShortUrls();
        dataAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);
        shortUrlList.setAdapter(dataAdapter);
        return dataAdapter.getCount();
    }

    private void refreshList() {
        data = (ArrayList<String>) helper.fetchShortUrls();
        dataAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);
        dataAdapter.notifyDataSetChanged();
        shortUrlList.setAdapter(dataAdapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
        {
            getMenuInflater().inflate(R.menu.menu_main,menu);
            return true;
        }
    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        int id = item.getItemId();
        if (id == R.id.action_wipe)
        {
            helper = new UrlDbHelper(getApplicationContext());

            if (loadDataInList() > 0) {
                new AlertDialog.Builder(MainActivity.this)
                        .setTitle("Delete All URLs")
                        .setMessage("Are you sure you want to delete ALL the generated URLs?")
                        .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                helper.wipeData();
                                refreshList();
                                Toast.makeText(getApplicationContext(), "All the generated URLs are cleaned successfully !", Toast.LENGTH_LONG).show();
                            }
                        })
                        .setNegativeButton("No", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                // do nothing
                            }
                        })
                        .setIcon(R.drawable.ic_warning)
                        .show();
            } else {
                Toast.makeText(getApplicationContext(), "No Data to Clear !", Toast.LENGTH_LONG).show();
            }

            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        new AlertDialog.Builder(MainActivity.this)
                .setTitle("Exit")
                .setMessage("Do You Want To Quit ?")
                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        finish();
                    }
                })
                .setNegativeButton("No", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // do nothing
                    }
                })
                .setIcon(R.drawable.ic_info)
                .show();
    }
}
