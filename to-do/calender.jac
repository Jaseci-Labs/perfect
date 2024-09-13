node year{
    has id: str;

}

node month{
    has id: str;
}

node week{
    has id: str;
}

node day{
    has id: str;
}

walker calender{
    has months: list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    has years: list = list(range(2023, 2041));

    can create with `root entry;
}

:walker:calender:can:create{

    year_nodes = [year(id = y) for y in self.years];
    month_nodes = [month(id = m) for m in self.months];

    here ++> year_nodes;
    year_nodes ++> month_nodes;


}

with entry{
    root spawn calender();
    d1=dotgen();
    print(d1);
}