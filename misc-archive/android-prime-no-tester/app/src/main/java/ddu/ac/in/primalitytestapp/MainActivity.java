package ddu.ac.in.primalitytestapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    int number;
    Button b1,b2;
    TextView t1,myScore;
    boolean isPrime = true;
    boolean myAns = false;
    Random r;
    int scoreCount = 0,temp = 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        b1 = (Button) findViewById(R.id.yesButton);
        b2 = (Button) findViewById(R.id.noButton);
        t1 = (TextView) findViewById(R.id.questionText);
        myScore = (TextView) findViewById(R.id.myScore);

        r = new Random();
        number = r.nextInt(100-1+1)+1; // generating prime number between 1 to 100

        t1.setText("Is "+number+" A Prime Number ?");

        isPrime = isPrime(number);

        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAns = true;
                if(myAns == isPrime)
                {
                    Toast.makeText(getApplicationContext(),"Correct Answer !",Toast.LENGTH_LONG).show();
                    number = r.nextInt(100-1+1)+1;
                    t1.setText("Is "+number+" A Prime Number ?");
                    isPrime = isPrime(number);
                    scoreCount += 1;
                    myScore.setText("Score : "+scoreCount);
                }
                else
                {
                    Toast.makeText(getApplicationContext(),"Wrong Answer !",Toast.LENGTH_LONG).show();
                    number = r.nextInt(100-1+1)+1;
                    t1.setText("Is "+number+" A Prime Number ?");
                    isPrime = isPrime(number);
                    scoreCount -= 1;
                    if(scoreCount <= 0)
                    {
                        scoreCount = 0;
                    }
                    myScore.setText("Score : "+scoreCount);
                }
            }
        });

        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myAns = false;
                if(myAns == isPrime)
                {
                    Toast.makeText(getApplicationContext(),"Correct Answer !",Toast.LENGTH_LONG).show();
                    number = r.nextInt(100-1+1)+1;
                    t1.setText("Is "+number+" A Prime Number ?");
                    isPrime = isPrime(number);
                    scoreCount += 1;
                    myScore.setText("Score : "+scoreCount);
                }
                else
                {
                    Toast.makeText(getApplicationContext(),"Wrong Answer !",Toast.LENGTH_LONG).show();
                    number = r.nextInt(100-1+1)+1;
                    t1.setText("Is "+number+" A Prime Number ?");
                    isPrime = isPrime(number);
                    scoreCount -= 1;
                    if(scoreCount <= 0)
                    {
                        scoreCount = 0;
                    }
                    myScore.setText("Score : "+scoreCount);
                }
            }
        });

    }
    public boolean isPrime(int number)
    {
        boolean flag = true;
        for(int i=2;i<=number/2;i++)
        {
            temp=number%i;
            if(temp==0)
            {
                flag=false;
                break;
            }
        }
        return flag;
    }
}
