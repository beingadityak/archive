package com.beingadityak.mycontacts;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class EditActivity extends AppCompatActivity {

    String name,oldno,oldno2,oldmailid;
    EditText newName,newNo,newNo2,newEmail;
    Button submit2,cancel;
    DbHelper helper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        name = getIntent().getExtras().getString("oldname");
        oldno = getIntent().getExtras().getString("oldno");
        oldno2 = getIntent().getExtras().getString("oldno2");
        oldmailid = getIntent().getExtras().getString("oldmailid");
        helper = new DbHelper(getApplicationContext());

        newName = (EditText) findViewById(R.id.newName);
        newNo = (EditText) findViewById(R.id.newNum);
        newNo2 = (EditText) findViewById(R.id.newNum2);
        newEmail = (EditText) findViewById(R.id.newMailID);
        submit2 = (Button) findViewById(R.id.submit2);
        cancel = (Button) findViewById(R.id.cancel);

        newName.setText(name);
        newNo.setText(oldno);
        newNo2.setText(oldno2);
        newEmail.setText(oldmailid);

        submit2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String n_name = newName.getText().toString();
                String n_no = newNo.getText().toString();
                String n_no2 = newNo2.getText().toString();
                String n_email = newEmail.getText().toString();

                int count = helper.updateData(name,n_name,n_no,n_no2,n_email);
                if(count > 0)
                {
                    Toast.makeText(getApplicationContext(),"Data Updated Successfully !",Toast.LENGTH_LONG).show();
                    Intent main = new Intent(getApplicationContext(),MainActivity.class);
                    startActivity(main);
                    finish();
                }
            }
        });

        cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent main = new Intent(getApplicationContext(),MainActivity.class);
                startActivity(main);
                finish();
            }
        });
    }
}
