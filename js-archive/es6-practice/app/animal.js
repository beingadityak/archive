class Animal
{
    constructor(name,height)
    {
        this.name = name;
        this.height = height;
    }
    hello()
    {
        console.log(`Hi ! My name is ${this.name}`);
    }
}

export default Animal;