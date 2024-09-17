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
    has months: list = ["January"];
    has years: list = list(range(2023, 2024));

    can create with `root entry;
}

:walker:calender:can:create{

    year_nodes = [year(id = y) for y in self.years];
    here ++> year_nodes;

    can get_days(y: int,m: int){
        days = cal.monthrange(y, m)[1];
        return days;
    }

    for y in year_nodes{
        month_nodes = [month(id=i+1, name=m) for (i, m) in enumerate(self.months)];
        y ++> month_nodes;
        
        for m in month_nodes{
            days_in_month = get_days(y.id, m.id);
            day_nodes = [day(id=str(i+1)) for i in range(days_in_month)];
            m ++> day_nodes;
        }
    }
}

with entry{
    root spawn calender();
    d1=dotgen();
    print(d1);
}