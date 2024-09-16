import:py calendar as cal;

node year{
    has id: int;

}

node month{
    has id: int;
    has name: str;
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
    month_nodes = [month(id=i+1, name=m) for (i, m) in enumerate(self.months)];
    day_nodes = [day(id=d) for d in range(1, 32)];

    can get_days(y: int,m: int){
        days = cal.monthrange(y, m)[1];
        return days;
    }

    here ++> year_nodes;
    year_nodes ++> month_nodes;

}

with entry{
    root spawn calender();
    d1=dotgen();
    print(d1);
}