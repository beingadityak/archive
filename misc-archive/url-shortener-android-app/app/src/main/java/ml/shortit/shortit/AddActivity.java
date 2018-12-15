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

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import org.json.JSONObject;

public class AddActivity extends AppCompatActivity {

    EditText longUrl;
    FloatingActionButton shorten;
    View parentLayout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add);

        final ActionBar actionBar = getSupportActionBar();
        assert actionBar != null;

        actionBar.setDisplayHomeAsUpEnabled(true);
        actionBar.setHomeAsUpIndicator(R.drawable.back_arrow);

        longUrl = (EditText) findViewById(R.id.editText);
        shorten = (FloatingActionButton) findViewById(R.id.button);
        parentLayout = findViewById(android.R.id.content);

        shorten.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String lUrl = longUrl.getText().toString();
                try {
                    String sUrl = new ShortenAPIConnector(getApplicationContext()).execute(lUrl).get();
                    String shortURL = new JSONObject(sUrl).getString("url");
                    if(shortURL.equalsIgnoreCase("Invalid URL") || shortURL.equalsIgnoreCase("Generation error"))
                    {
                        //do not add the value in database
                        Toast.makeText(getApplicationContext(),shortURL,Toast.LENGTH_LONG).show();
                    }
                    else
                    {
                        //add value in database
                        UrlDbHelper helper = new UrlDbHelper(getApplicationContext());
                        //setting values through setters
                        helper.setLongUrl(lUrl);
                        helper.setShortUrl(shortURL);
                        //final insertion
                        helper.insertValues();
                        //Show a toast
                        Toast.makeText(getApplicationContext(), "New ShortR URL generated !", Toast.LENGTH_LONG).show();
                        // Go Back to main
                        Intent main = new Intent(getApplicationContext(),MainActivity.class);
                        startActivity(main);
                        finish();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

                // If user doesn't want to add new Short URL
    @Override
    public void onBackPressed(){
        Intent main = new Intent(getApplicationContext(),MainActivity.class);
        startActivity(main);
        finish();
    }
}
