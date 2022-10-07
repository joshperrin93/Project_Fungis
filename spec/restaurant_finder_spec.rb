RSpec.describe "RestaurantFinder" do
    # it "calls the Google Places API and returns info about the first place" do
    #     place2 = double('place')

    #     allow(place2).to receive(:item) {"\"WAVE\", \"11 Dispensary Ln, London E8 1FT, United Kingdom\", 4.7, [#<GooglePlaces::Photo:0x000000...zaSyDSDGq-UtxFetovCVYSqyEAT9VreL5IEEQ\">], \"ChIJi5rjorccdkgRhHRpRo5pQDE\", 51.5240081, -0.0727076"}

    #     places = RestaurantFinder.new("London", " ")
    #     expect(places.find.first).to eq(["WAVE", "11 Dispensary Ln, London E8 1FT, United Kingdom", 4.7, [#<GooglePlaces::Photo:0x00000001074...yDSDGq-UtxFetovCVYSqyEAT9VreL5IEEQ">], "ChIJF_kxdtYddkgR2ljex8ywClg", 51.54887739999999, -0.0546374])
    # end
    it "calls the Google Places API and returns the name of the first place" do
        place2 = double('place')

        allow(place2).to receive(:item) {"Unity Diner"}

        places = RestaurantFinder.new("London", " ")
        expect(places.find_name.first).to eq(["Unity Diner"])
        end 

    # xit "searches the Google Places API by place_id and returns the name of the place" do
    #     place2 = double('place')

    #     allow(place2).to receive(:item) {"The Vurger Company"}

    #     places = RestaurantFinder.new("", "ChIJi5rjorccdkgRhHRpRo5pQDE")
    #     expect(places.restaurant_info).to eq(["The Vurger Company"])
    #     end 
    # xit "searches the Google Places API by place_id and returns the info of the place" do
    #     place2 = double('place')

    #     allow(place2).to receive(:item) {"The Vurger Company"}

    #     places = RestaurantFinder.new("", "ChIJi5rjorccdkgRhHRpRo5pQDE")
    #     expect(places.restaurant_info.formatted_address).to include("Unit 9, Richmix, Avant Garde, Cygnet St, London E1 6LD, UK")
    #     end 
end