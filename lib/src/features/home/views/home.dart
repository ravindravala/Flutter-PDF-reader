import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfreader/src/constant/app_string.dart';
import 'package:pdfreader/src/features/home/cubit/home_cubit.dart';
import 'package:pdfreader/src/features/pdf_view/view/open_pdf.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).scanPDF();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.appName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeError) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is HomeLoaded) {
          var data = state.pdfFiles;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: data.length,
            itemBuilder: (_, index) => ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OpenPDF(fileInfo: data[index]),
                  ),
                );
              },
              leading: const Icon(Icons.picture_as_pdf_sharp),
              title: Text(data[index].name),
              subtitle: Text(data[index].folder,style: TextStyle(color:  Theme.of(context).colorScheme.primary),),
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}
