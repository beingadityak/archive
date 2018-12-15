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

public class AddActivity extends AppCompatActivity {

    Button addContact, addNo;
    EditText name,number,number2,emailid;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        addContact = (Button) findViewById(R.id.button2);
        addNo = (Button) findViewById(R.id.button);

        name = (EditText) findViewById(R.id.editText);
        number = (EditText) findViewById(R.id.editText2);
        number2 = (EditText) findViewById(R.id.editText3);
        emailid = (EditText) findViewById(R.id.editText4);

        number2.setEnabled(false);

        addNo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                number2.setEnabled(true);
            }
        });

        addContact.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String no_2 = number2.getText().toString().trim();
                String contact_name = name.getText().toString().trim();
                String contact_no = number.getText().toString().trim();
                String email_id = emailid.getText().toString();

                if(contact_name == null || contact_no == null || email_id == null)
                {
                    Toast.makeText(getApplicationContext(),"Please Enter The Following Fields : Name, Email ID and Phone No !",Toast.LENGTH_LONG).show();
                }
                else
                {
                    DbHelper helper = new DbHelper(getApplicationContext());
                    helper.setName(contact_name);
                    helper.setNo(contact_no);
                    helper.setNo2(no_2);
                    helper.setEmail(email_id);
                    int count = helper.insertValues();
                    if(count > 0)
                    {
                        Toast.makeText(getApplicationContext(),"Contact Added Successfully !",Toast.LENGTH_LONG).show();
                        Intent home = new Intent(getApplicationContext(),MainActivity.class);
                        startActivity(home);
                        finish();
                    }
                }
            }
        });


    }

    @Override
    public void onBackPressed(){
        Intent main = new Intent(getApplicationContext(),MainActivity.class);
        startActivity(main);
        finish();
    }

}
