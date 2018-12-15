package com.beingadityak.mycontacts;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.Collections;


public class MainActivity extends AppCompatActivity {


    ArrayList<String> data;
    ListView contactList;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        contactList = (ListView) findViewById(R.id.listView);

        loadDataInList();

        contactList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent actions = new Intent(getApplicationContext(),ActionActivity.class);
                actions.putExtra("name",contactList.getItemAtPosition(position).toString());
                startActivity(actions);
                finish();
            }
        });
    }

    private void loadDataInList() {
        DbHelper helper = new DbHelper(getApplicationContext());
        data = (ArrayList<String>) helper.fetchNames();
        Collections.sort(data);
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1,data);
        contactList.setAdapter(dataAdapter);
    }

    @Override
        public boolean onCreateOptionsMenu(Menu menu) {
            // Inflate the menu; this adds items to the action bar if it is present.
            getMenuInflater().inflate(R.menu.menu_main, menu);
            return true;
        }

        @Override
        public boolean onOptionsItemSelected(MenuItem item) {
            // Handle action bar item clicks here. The action bar will
            // automatically handle clicks on the Home/Up button, so long
            // as you specify a parent activity in AndroidManifest.xml.
            int id = item.getItemId();

            //noinspection SimplifiableIfStatement
            if (id == R.id.action_newcontact) {
                Intent add = new Intent(getApplicationContext(),AddActivity.class);
                startActivity(add);
                finish();
                return true;
            }

            return super.onOptionsItemSelected(item);
    }
}
