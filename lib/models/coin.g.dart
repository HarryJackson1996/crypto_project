// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinAdapter extends TypeAdapter<Coin> {
  @override
  final int typeId = 0;

  @override
  Coin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coin(
      bookmarked: fields[0] as bool,
      id: fields[1] as int,
      name: fields[2] as String,
      symbol: fields[3] as String,
      slug: fields[4] as String,
      cmcRank: fields[5] as int,
      numMarketPairs: fields[6] as int,
      circulatingSupply: fields[7] as double,
      totalSupply: fields[8] as double,
      maxSupply: fields[9] as double,
      lastUpdated: fields[10] as DateTime,
      dateAdded: fields[11] as DateTime,
      tags: (fields[12] as List)?.cast<String>(),
      platform: fields[13] as dynamic,
      quote: (fields[14] as Map)?.cast<String, Quote>(),
    );
  }

  @override
  void write(BinaryWriter writer, Coin obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.bookmarked)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.slug)
      ..writeByte(5)
      ..write(obj.cmcRank)
      ..writeByte(6)
      ..write(obj.numMarketPairs)
      ..writeByte(7)
      ..write(obj.circulatingSupply)
      ..writeByte(8)
      ..write(obj.totalSupply)
      ..writeByte(9)
      ..write(obj.maxSupply)
      ..writeByte(10)
      ..write(obj.lastUpdated)
      ..writeByte(11)
      ..write(obj.dateAdded)
      ..writeByte(12)
      ..write(obj.tags)
      ..writeByte(13)
      ..write(obj.platform)
      ..writeByte(14)
      ..write(obj.quote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuoteAdapter extends TypeAdapter<Quote> {
  @override
  final int typeId = 1;

  @override
  Quote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quote(
      price: fields[0] as double,
      volume24H: fields[1] as double,
      percentChange1H: fields[2] as double,
      percentChange24H: fields[3] as double,
      percentChange7D: fields[4] as double,
      marketCap: fields[5] as double,
      lastUpdated: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Quote obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.volume24H)
      ..writeByte(2)
      ..write(obj.percentChange1H)
      ..writeByte(3)
      ..write(obj.percentChange24H)
      ..writeByte(4)
      ..write(obj.percentChange7D)
      ..writeByte(5)
      ..write(obj.marketCap)
      ..writeByte(6)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
