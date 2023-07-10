all: build run

build:
	docker build -t nodraak/gitg .


	#docker run --rm nodraak/gitg cat /usr/bin/gitg > ./gitg
	#chmod +x ./gitg
	# sudo mv ./gitg /usr/bin/gitg
	# sudo ln -s /usr/lib/gitg/libgitg-ext-1.0.so.0 /usr/lib/x86_64-linux-gnu/libgitg-ext-1.0.so.0






#run:
#	docker run -ti --rm nodraak/gitg


# https://gitlab.gnome.org/GNOME/gitg/-/issues/351

# https://gitlab.gnome.org/GNOME/gitg/-/merge_requests/112/diffs
# 2019

# RUN git checkout 4ce63eeb # 2022-10-10 22:18:01 +0200 Allow to sign commits Adwait Rawat
# 1.005 ../libgitg/gitg-stage.vala:473.17-473.49: error: The name `create_commit_buffer' does not exist in the context of `Gitg.Repository'
# 1.005   473 |                   var data = d_repository.create_commit_buffer(author,
# 1.005       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.005 ../libgitg/gitg-stage.vala:487.12-487.52: error: The name `create_commit_with_signature' does not exist in the context of `Gitg.Repository'
# 1.005   487 |                   ret = d_repository.create_commit_with_signature(data, signature, null);

# RUN git checkout 32271214 # 2022-10-09 13:26:24 +0000 Update Russian translation Aleksandr Melman
