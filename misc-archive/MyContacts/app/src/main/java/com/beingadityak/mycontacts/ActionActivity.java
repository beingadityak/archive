package com.beingadityak.mycontacts;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class ActionActivity extends AppCompatActivity {

    TextView contactName;
    ArrayList<String> content;
    String name;
    DbHelper helper;

    Button call, message;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_action);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        contactName = (TextView) findViewById(R.id.contactName);
        int[] textViewIds = new int[]{R.id.num1, R.id.num2, R.id.mailid};
        name = getIntent().getExtras().getString("name");
        contactName.setText(name);

        helper = new DbHelper(getApplicationContext());

        content = new ArrayList<>();
        content = (ArrayList<String>) helper.fetchData(name);
        for (int i = 0; i < content.size(); i++) {
            ((TextView) findViewById(textViewIds[i])).setText(content.get(i));
        }
        call = (Button) findViewById(R.id.button3);
        message = (Button) findViewById(R.id.button4);
        call.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                registerForContextMenu(call);
                openContextMenu(call);
            }
        });
        message.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                registerForContextMenu(message);
                openContextMenu(message);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_actions, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_editcontact) {
            // Edit Details
            content = new ArrayList<String>();
            String extraNames[] = new String[]{"oldno", "oldno2", "oldmailid"};
            content = (ArrayList<String>) helper.fetchData(name);
            Intent edit = new Intent(getApplicationContext(), EditActivity.class);
            edit.putExtra("oldname", name);
            for (int i = 0; i < content.size(); i++) {
                edit.putExtra(extraNames[i], content.get(i));
            }
            startActivity(edit);
            finish();
            return true;
        } else if (id == R.id.action_delcontact) {
            // Delete the Contact
            int count = helper.deleteData(name);
            if (count > 0) {
                Toast.makeText(getApplicationContext(), "Contact Deleted Successfully !", Toast.LENGTH_LONG).show();
            }
            Intent main = new Intent(getApplicationContext(), MainActivity.class);
            startActivity(main);
            finish();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        String num1 = ((TextView) findViewById(R.id.num1)).getText().toString();
        String num2 = ((TextView) findViewById(R.id.num2)).getText().toString();
        if (v == call) {
            menu.setHeaderTitle("Call");
            menu.add(0, v.getId(), 0, num1);
            if (!num2.isEmpty()) {
                menu.add(0, v.getId(), 0, num2);
            }
        } else if (v == message) {
            menu.setHeaderTitle("Message");
            menu.add(0, v.getId(), 0, num1);
            if (!num2.isEmpty()) {
                menu.add(0, v.getId(), 0, num2);
            }
        }
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        String number = item.getTitle().toString();
        ;
        int callId = item.getItemId();
        if (callId == R.id.button3) {
            Intent phone = new Intent(Intent.ACTION_CALL);
            phone.setData(Uri.parse("tel:" + number));
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(getApplicationContext(),"Please Set The Phone Call Permission for this App !",Toast.LENGTH_LONG).show();
            }
            else {
                Toast.makeText(getApplicationContext(), "Calling : " + number, Toast.LENGTH_LONG).show();
                startActivity(phone);
            }
        }
        else if(callId == R.id.button4)
        {
            Toast.makeText(getApplicationContext(),"Messaging : "+number,Toast.LENGTH_LONG).show();
        }
        return true;
    }
    @Override
    public void onBackPressed(){
        Intent main = new Intent(getApplicationContext(),MainActivity.class);
        startActivity(main);
        finish();
    }
}
